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
  final RecipeRepository _recipeRepository = RecipeRepository.shared;

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _prepTimeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!mounted) return;
    if (_formKey.currentState?.validate() ?? false) {
      final newRecipe = Recipe(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        category: _categoryController.text.trim(),
        prepTime: _prepTimeController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: '',
      );

      _recipeRepository.addRecipe(newRecipe);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recette enregistrée avec succès !')),
      );

      _formKey.currentState?.reset();
      _titleController.clear();
      _categoryController.clear();
      _prepTimeController.clear();
      _descriptionController.clear();

      await Future<void>.delayed(const Duration(milliseconds: 200));
      if (!mounted) return;
      GoRouter.of(context).go('/');
    }
  }

  Widget _buildFormFields({required bool wide}) {
    final titleField = TextFormField(
      key: const Key('titleField'),
      controller: _titleController,
      decoration: const InputDecoration(labelText: 'Titre de la recette'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Veuillez saisir un titre.';
        }
        return null;
      },
    );

    final categoryField = TextFormField(
      key: const Key('categoryField'),
      controller: _categoryController,
      decoration: const InputDecoration(labelText: 'Catégorie'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Veuillez saisir une catégorie.';
        }
        return null;
      },
    );

    final prepTimeField = TextFormField(
      key: const Key('prepTimeField'),
      controller: _prepTimeController,
      decoration: const InputDecoration(labelText: 'Temps de préparation'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Veuillez saisir un temps de préparation.';
        }
        return null;
      },
    );

    final descriptionField = TextFormField(
      key: const Key('descriptionField'),
      controller: _descriptionController,
      minLines: wide ? 8 : 4,
      maxLines: wide ? 12 : 6,
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
    );

    final submitButton = ElevatedButton(
      onPressed: () {
        _formKey.currentState!.validate();
        _submitForm();
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Text('Enregistrer la recette'),
      ),
    );

    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                titleField,
                const SizedBox(height: 16),
                categoryField,
                const SizedBox(height: 16),
                prepTimeField,
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                descriptionField,
                const SizedBox(height: 24),
                submitButton,
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        titleField,
        const SizedBox(height: 16),
        categoryField,
        const SizedBox(height: 16),
        prepTimeField,
        const SizedBox(height: 16),
        descriptionField,
        const SizedBox(height: 24),
        submitButton,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une recette')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 720;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: _buildFormFields(wide: isWide),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
