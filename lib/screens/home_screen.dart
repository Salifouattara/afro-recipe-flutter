import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../repositories/recipe_repository.dart';
import '../widgets/custom_header.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeRepository = RecipeRepository.shared;
    final allRecipes = recipeRepository.getAllRecipes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Recipes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add'),
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final crossAxisCount = maxWidth >= 900
                ? 3
                : maxWidth >= 600
                ? 2
                : 1;
            final childAspectRatio = maxWidth >= 900
                ? 1.5
                : maxWidth >= 600
                ? 1.6
                : 1.2;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomHeader(
                      title: 'Bienvenue',
                      subtitle:
                          'Découvrez des recettes faciles et rapides à préparer.',
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          itemCount: allRecipes.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: childAspectRatio,
                              ),
                          itemBuilder: (context, index) {
                            final recipe = allRecipes[index];
                            return RecipeCard(
                              recipe: recipe,
                              onTap: () => context.push('/detail/${recipe.id}'),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
