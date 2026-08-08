import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/data/recipe_data.dart';

void main() {
  test('Recipe data contains expected recipes', () {
    expect(recipes, isNotEmpty);
    expect(recipes.first.id, '1');
    expect(recipes.first.title, 'Salade méditerranéenne');
  });

  test('getRecipeById returns the correct recipe', () {
    final recipe = getRecipeById('2');

    expect(recipe.id, '2');
    expect(recipe.title, 'Pâtes aux champignons');
    expect(recipe.category, 'Plat principal');
  });

  test('searchRecipes returns filtered results', () {
    final filtered = searchRecipes('pâtes');

    expect(filtered.length, 1);
    expect(filtered.first.title, 'Pâtes aux champignons');
  });
}
