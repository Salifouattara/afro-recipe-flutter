import '../models/recipe.dart';
import '../data/recipe_data.dart';

/// RecipeRepository encapsule l'accès aux données des recettes
/// Cette classe centralise la gestion des recettes, permettant une séparation
/// claire entre la logique métier et la présentation.
class RecipeRepository {
  /// Shared singleton instance. Use `RecipeRepository.shared` when you want a
  /// single shared in-memory store for the running app.
  static final RecipeRepository shared = RecipeRepository._shared();

  /// Underlying list of recipes for this repository instance.
  final List<Recipe> _recipes;

  /// Default constructor: creates a fresh repository instance seeded with
  /// the initial sample data from `data/recipe_data.dart`. Useful for tests or isolated usage.
  RecipeRepository() : _recipes = List<Recipe>.from(recipes);

  /// Private named constructor used for the shared singleton.
  RecipeRepository._shared() : _recipes = List<Recipe>.from(recipes);

  /// Récupère la liste complète des recettes
  List<Recipe> getAllRecipes() => List.unmodifiable(_recipes);

  /// Récupère une recette par son identifiant
  /// Retourne une recette par défaut si non trouvée
  Recipe getRecipeById(String id) {
    try {
      return _recipes.firstWhere(
        (recipe) => recipe.id == id,
        orElse: () => const Recipe(
          id: '',
          title: 'Recette introuvable',
          category: '',
          prepTime: '',
          description: 'Aucune recette ne correspond à cet identifiant.',
          imageUrl: '',
        ),
      );
    } catch (e) {
      return const Recipe(
        id: '',
        title: 'Erreur',
        category: '',
        prepTime: '',
        description: 'Une erreur s\'est produite lors de la recherche.',
        imageUrl: '',
      );
    }
  }

  /// Recherche les recettes selon une requête
  /// La recherche est effectuée sur le titre, la catégorie et la description
  List<Recipe> searchRecipes(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return getAllRecipes();
    }

    return _recipes.where((recipe) {
      return recipe.title.toLowerCase().contains(normalized) ||
          recipe.category.toLowerCase().contains(normalized) ||
          recipe.description.toLowerCase().contains(normalized);
    }).toList();
  }

  /// Filtre les recettes par catégorie
  List<Recipe> getRecipesByCategory(String category) {
    if (category.isEmpty) {
      return getAllRecipes();
    }
    return _recipes
        .where(
          (recipe) =>
              recipe.category.toLowerCase().contains(category.toLowerCase()),
        )
        .toList();
  }

  /// Récupère toutes les catégories disponibles
  List<String> getAllCategories() {
    final categories = <String>{};
    for (var recipe in _recipes) {
      categories.add(recipe.category);
    }
    return categories.toList();
  }

  /// Ajoute une nouvelle recette
  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }

  /// Retourne le nombre total de recettes
  int getRecipeCount() {
    return _recipes.length;
  }

  /// Recherche les recettes par terme avec des résultats limités
  List<Recipe> searchRecipesLimited(String query, int limit) {
    return searchRecipes(query).take(limit).toList();
  }
}
