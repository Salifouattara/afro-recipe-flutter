import '../models/recipe.dart';

final List<Recipe> recipes = [
  const Recipe(
    id: '1',
    title: 'Salade méditerranéenne',
    category: 'Entrée',
    prepTime: '15 min',
    description: 'Une salade fraîche avec tomates, concombre, feta et herbes.',
    imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=800&q=80',
  ),
  const Recipe(
    id: '2',
    title: 'Pâtes aux champignons',
    category: 'Plat principal',
    prepTime: '30 min',
    description: 'Pâtes crémeuses sautées avec champignons et parmesan.',
    imageUrl: 'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80',
  ),
  const Recipe(
    id: '3',
    title: 'Smoothie fruité',
    category: 'Boisson',
    prepTime: '10 min',
    description: 'Smoothie vitaminé à base de banane, fraise et lait d’amande.',
    imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=800&q=80',
  ),
  const Recipe(
    id: '4',
    title: 'Tarte aux pommes',
    category: 'Dessert',
    prepTime: '50 min',
    description: 'Tarte croustillante aux pommes, cannelle et sucre vanillé.',
    imageUrl: 'https://images.unsplash.com/photo-1512058564366-c9e7a7911d3f?auto=format&fit=crop&w=800&q=80',
  ),
];

Recipe getRecipeById(String id) {
  return recipes.firstWhere(
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
}

List<Recipe> searchRecipes(String query) {
  final normalized = query.trim().toLowerCase();
  if (normalized.isEmpty) {
    return recipes;
  }

  return recipes.where((recipe) {
    return recipe.title.toLowerCase().contains(normalized) ||
        recipe.category.toLowerCase().contains(normalized) ||
        recipe.description.toLowerCase().contains(normalized);
  }).toList();
}
