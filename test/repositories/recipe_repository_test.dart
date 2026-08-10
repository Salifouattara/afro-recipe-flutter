import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/models/recipe.dart';
import 'package:my_app/repositories/recipe_repository.dart';

void main() {
  late RecipeRepository recipeRepository;

  setUp(() {
    recipeRepository = RecipeRepository();
  });

  group('RecipeRepository', () {
    group('getAllRecipes', () {
      test('retourne une liste non vide de recettes', () {
        final recipes = recipeRepository.getAllRecipes();
        expect(recipes, isNotEmpty);
        expect(recipes.length, greaterThan(0));
      });

      test('retourne une liste immuable', () {
        final recipes = recipeRepository.getAllRecipes();
        expect(
          () => recipes.add(
            const Recipe(
              id: 'test',
              title: 'Test',
              category: 'Test',
              prepTime: '10 min',
              description: 'Test',
              imageUrl: '',
            ),
          ),
          throwsUnsupportedError,
        );
      });

      test('contient les recettes avec les bons IDs', () {
        final recipes = recipeRepository.getAllRecipes();
        final ids = recipes.map((r) => r.id).toList();
        expect(ids, contains('1'));
        expect(ids, contains('2'));
        expect(ids, contains('3'));
        expect(ids, contains('4'));
      });
    });

    group('getRecipeById', () {
      test('retourne la recette correcte avec l\'ID 1', () {
        final recipe = recipeRepository.getRecipeById('1');
        expect(recipe.id, '1');
        expect(recipe.title, 'Salade méditerranéenne');
        expect(recipe.category, 'Entrée');
      });

      test('retourne la recette correcte avec l\'ID 2', () {
        final recipe = recipeRepository.getRecipeById('2');
        expect(recipe.id, '2');
        expect(recipe.title, 'Pâtes aux champignons');
        expect(recipe.category, 'Plat principal');
      });

      test('retourne une recette par défaut pour un ID inexistant', () {
        final recipe = recipeRepository.getRecipeById('999');
        expect(recipe.id, isEmpty);
        expect(recipe.title, 'Recette introuvable');
      });

      test('gère les IDs null et vides', () {
        final recipe1 = recipeRepository.getRecipeById('');
        expect(recipe1.id, isEmpty);

        final recipe2 = recipeRepository.getRecipeById('   ');
        expect(recipe2.id, isEmpty);
      });
    });

    group('searchRecipes', () {
      test('retourne toutes les recettes pour une requête vide', () {
        final results = recipeRepository.searchRecipes('');
        expect(results.length, recipeRepository.getAllRecipes().length);
      });

      test('retourne toutes les recettes pour une requête avec espaces', () {
        final results = recipeRepository.searchRecipes('   ');
        expect(results.length, recipeRepository.getAllRecipes().length);
      });

      test('trouve les recettes par titre', () {
        final results = recipeRepository.searchRecipes('Pâtes');
        expect(results, isNotEmpty);
        expect(results.first.title, 'Pâtes aux champignons');
        expect(results.length, 1);
      });

      test('trouve les recettes par catégorie', () {
        final results = recipeRepository.searchRecipes('Dessert');
        expect(results, isNotEmpty);
        expect(results.first.category, 'Dessert');
      });

      test('trouve les recettes par description', () {
        final results = recipeRepository.searchRecipes('fraîche');
        expect(results, isNotEmpty);
      });

      test('est insensible à la casse', () {
        final results1 = recipeRepository.searchRecipes('pâtes');
        final results2 = recipeRepository.searchRecipes('PÂTES');
        final results3 = recipeRepository.searchRecipes('Pâtes');
        expect(results1.length, results2.length);
        expect(results2.length, results3.length);
      });

      test('retourne une liste vide pour une requête sans résultats', () {
        final results = recipeRepository.searchRecipes('XXXXXX');
        expect(results, isEmpty);
      });
    });

    group('getRecipesByCategory', () {
      test('retourne toutes les recettes pour une catégorie vide', () {
        final results = recipeRepository.getRecipesByCategory('');
        expect(results.length, recipeRepository.getAllRecipes().length);
      });

      test('retourne les recettes de la catégorie Entrée', () {
        final results = recipeRepository.getRecipesByCategory('Entrée');
        expect(results, isNotEmpty);
        expect(results.every((r) => r.category.contains('Entrée')), true);
      });

      test('retourne les recettes de la catégorie Plat principal', () {
        final results = recipeRepository.getRecipesByCategory('Plat principal');
        expect(results, isNotEmpty);
      });

      test('est insensible à la casse', () {
        final results1 = recipeRepository.getRecipesByCategory('entrée');
        final results2 = recipeRepository.getRecipesByCategory('ENTRÉE');
        expect(results1.length, results2.length);
      });
    });

    group('getAllCategories', () {
      test('retourne une liste non vide de catégories', () {
        final categories = recipeRepository.getAllCategories();
        expect(categories, isNotEmpty);
      });

      test('contient toutes les catégories attendues', () {
        final categories = recipeRepository.getAllCategories();
        expect(categories, contains('Entrée'));
        expect(categories, contains('Plat principal'));
        expect(categories, contains('Boisson'));
        expect(categories, contains('Dessert'));
      });

      test('ne contient pas de doublons', () {
        final categories = recipeRepository.getAllCategories();
        expect(categories.length, categories.toSet().length);
      });
    });

    group('addRecipe', () {
      test('ajoute une nouvelle recette', () {
        final initialCount = recipeRepository.getRecipeCount();
        final newRecipe = const Recipe(
          id: 'test_1',
          title: 'Recette de test',
          category: 'Test',
          prepTime: '20 min',
          description: 'Ceci est une recette de test.',
          imageUrl: '',
        );
        recipeRepository.addRecipe(newRecipe);
        expect(recipeRepository.getRecipeCount(), initialCount + 1);
      });

      test('la recette ajoutée peut être trouvée', () {
        final newRecipe = const Recipe(
          id: 'test_2',
          title: 'Recette trouvable',
          category: 'Test',
          prepTime: '15 min',
          description: 'Cette recette doit être trouvable.',
          imageUrl: '',
        );
        recipeRepository.addRecipe(newRecipe);
        final found = recipeRepository.getRecipeById('test_2');
        expect(found.id, 'test_2');
        expect(found.title, 'Recette trouvable');
      });

      test('la recette ajoutée apparaît dans la recherche', () {
        final newRecipe = const Recipe(
          id: 'test_3',
          title: 'Recette recherchable',
          category: 'Test',
          prepTime: '25 min',
          description: 'Cette recette est recherchable par titre unique.',
          imageUrl: '',
        );
        recipeRepository.addRecipe(newRecipe);
        final results = recipeRepository.searchRecipes('recherchable');
        expect(results, isNotEmpty);
        expect(results.any((r) => r.id == 'test_3'), true);
      });
    });

    group('getRecipeCount', () {
      test('retourne le nombre correct de recettes', () {
        final count = recipeRepository.getRecipeCount();
        expect(count, equals(recipeRepository.getAllRecipes().length));
      });

      test('augmente après l\'ajout d\'une recette', () {
        final initialCount = recipeRepository.getRecipeCount();
        final newRecipe = const Recipe(
          id: 'count_test',
          title: 'Test du compte',
          category: 'Test',
          prepTime: '10 min',
          description: 'Pour tester le comptage.',
          imageUrl: '',
        );
        recipeRepository.addRecipe(newRecipe);
        expect(recipeRepository.getRecipeCount(), initialCount + 1);
      });
    });

    group('searchRecipesLimited', () {
      test('retourne un nombre limité de résultats', () {
        final results = recipeRepository.searchRecipesLimited('', 2);
        expect(results.length, lessThanOrEqualTo(2));
      });

      test(
        'respecte la limite avec une requête correspondant à plusieurs résultats',
        () {
          final allResults = recipeRepository.searchRecipes('');
          final limitedResults = recipeRepository.searchRecipesLimited('', 2);
          expect(limitedResults.length, lessThanOrEqualTo(2));
          expect(limitedResults.length, lessThanOrEqualTo(allResults.length));
        },
      );

      test('retourne une liste vide pour une limite de 0', () {
        final results = recipeRepository.searchRecipesLimited('', 0);
        expect(results, isEmpty);
      });

      test(
        'retourne les bons résultats limités pour une recherche spécifique',
        () {
          recipeRepository.addRecipe(
            const Recipe(
              id: 'limited_1',
              title: 'Pasta Test 1',
              category: 'Test',
              prepTime: '10 min',
              description: 'Test pasta 1',
              imageUrl: '',
            ),
          );
          recipeRepository.addRecipe(
            const Recipe(
              id: 'limited_2',
              title: 'Pasta Test 2',
              category: 'Test',
              prepTime: '10 min',
              description: 'Test pasta 2',
              imageUrl: '',
            ),
          );
          final results = recipeRepository.searchRecipesLimited('Pasta', 1);
          expect(results.length, 1);
        },
      );
    });
  });
}
