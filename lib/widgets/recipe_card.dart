import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

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
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: recipe.imageUrl.isEmpty
                    ? Container(color: Theme.of(context).colorScheme.surfaceVariant)
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
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text('${recipe.category} • ${recipe.prepTime}', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
