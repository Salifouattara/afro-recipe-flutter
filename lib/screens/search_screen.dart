import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/recipe_data.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class SearchScreen extends StatefulWidget {
  final List<Recipe>? recipes;

  const SearchScreen({super.key, this.recipes});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = searchRecipes(query, widget.recipes);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Rechercher une recette',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => query = value),
            ),
          ),
          Expanded(
            child: filteredRecipes.isEmpty
                ? Center(
                    child: Text(
                      query.isEmpty ? 'Aucune recette disponible.' : 'Aucune recette ne correspond à votre recherche.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredRecipes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];
                      return RecipeCard(
                        recipe: recipe,
                        onTap: () => context.push('/detail/${recipe.id}'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
