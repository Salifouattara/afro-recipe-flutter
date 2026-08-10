import 'package:flutter/material.dart';

import '../models/recipe.dart';

/// Widget réutilisable affichant une carte de recette
/// Utilisé dans HomeScreen et SearchScreen pour l'affichage des recettes.
/// Supporte le chargement d'images depuis l'URL et gère les erreurs de chargement.
class RecipeCard extends StatelessWidget {
  /// La recette à afficher
  final Recipe recipe;

  /// Callback appelé quand la carte est tapée
  final VoidCallback onTap;

  /// Crée un [RecipeCard]
  const RecipeCard({super.key, required this.recipe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 160,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: recipe.imageUrl.isEmpty
                    ? Container(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                      )
                    : Image.network(
                        recipe.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          alignment: Alignment.center,
                          child: const Icon(Icons.fastfood, size: 40),
                        ),
                      ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      recipe.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${recipe.category} • ${recipe.prepTime}',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
