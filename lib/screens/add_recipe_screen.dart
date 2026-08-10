import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _prepTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final RecipeRepository _recipeRepository = RecipeRepository();

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _prepTimeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Créer une nouvelle recette avec les données du formulaire
      final newRecipe = Recipe(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        category: _categoryController.text,
        prepTime: _prepTimeController.text,
        description: _descriptionController.text,
        imageUrl: '',
      );

      // Ajouter la recette au repository
      _recipeRepository.addRecipe(newRecipe);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recette enregistrée avec succès !')),
        );
        _formKey.currentState?.reset();
        _titleController.clear();
        _categoryController.clear();
        _prepTimeController.clear();
        _descriptionController.clear();
        await Future<void>.delayed(const Duration(milliseconds: 200));
        GoRouter.of(context).go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une recette')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                key: const Key('titleField'),
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre de la recette',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez saisir un titre.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('categoryField'),
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Catégorie'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez saisir une catégorie.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('prepTimeField'),
                controller: _prepTimeController,
                decoration: const InputDecoration(
                  labelText: 'Temps de préparation',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez saisir un temps de préparation.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('descriptionField'),
                controller: _descriptionController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez saisir une description.';
                  }
                  if (value.trim().length < 20) {
                    return 'La description doit contenir au moins 20 caractères.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text('Enregistrer la recette'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
