import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../repositories/recipe_repository.dart';

class DetailScreen extends StatelessWidget {
  final String recipeId;
  final RecipeRepository _recipeRepository = RecipeRepository.shared;

  DetailScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final recipe = _recipeRepository.getRecipeById(recipeId);
    final isNotFound = recipe.id.isEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Détails de la recette')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isNotFound
              ? Center(
                  child: Text(
                    'Recette introuvable',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (recipe.imageUrl.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            recipe.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 220,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceVariant,
                                  height: 220,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.fastfood, size: 60),
                                ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        recipe.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${recipe.category} • ${recipe.prepTime}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recipe.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => context.go('/search'),
                        icon: const Icon(Icons.search),
                        label: const Text('Retour à la recherche'),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
