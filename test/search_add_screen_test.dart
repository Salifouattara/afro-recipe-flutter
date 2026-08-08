import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/models/recipe.dart';
import 'package:my_app/screens/add_recipe_screen.dart';
import 'package:my_app/screens/search_screen.dart';

void main() {
  testWidgets('SearchScreen filters recipe list when text changes', (WidgetTester tester) async {
    const testRecipes = [
      Recipe(
        id: '1',
        title: 'Pâtes aux champignons',
        category: 'Plat principal',
        prepTime: '30 min',
        description: 'Pâtes crémeuses sautées avec champignons et parmesan.',
        imageUrl: '',
      ),
      Recipe(
        id: '2',
        title: 'Smoothie fruité',
        category: 'Boisson',
        prepTime: '10 min',
        description: 'Smoothie vitaminé à base de banane, fraise et lait d’amande.',
        imageUrl: '',
      ),
    ];

    await tester.pumpWidget(MaterialApp(home: SearchScreen(recipes: testRecipes)));
    await tester.pumpAndSettle();

    expect(find.text('Recherche'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'pâtes');
    await tester.pumpAndSettle();

    expect(find.textContaining('Pâtes aux champignons'), findsOneWidget);
    expect(find.textContaining('Smoothie fruité'), findsNothing);
  });

  testWidgets('AddRecipeScreen shows validation errors and navigates home after submit', (WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/add',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const Scaffold(body: Center(child: Text('HomeRoute')))),
        GoRoute(path: '/add', builder: (context, state) => const AddRecipeScreen()),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    expect(find.text('Ajouter une recette'), findsOneWidget);

    await tester.tap(find.text('Enregistrer la recette'));
    await tester.pumpAndSettle();

    expect(find.text('Veuillez saisir un titre.'), findsOneWidget);
    expect(find.text('Veuillez saisir une catégorie.'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('titleField')), 'Recette test');
    await tester.enterText(find.byKey(const Key('categoryField')), 'Snack');
    await tester.enterText(find.byKey(const Key('prepTimeField')), '20 min');
    await tester.enterText(find.byKey(const Key('descriptionField')), 'Ceci est une description de test suffisamment longue.');

    await tester.tap(find.text('Enregistrer la recette'));
    await tester.pumpAndSettle();

    expect(find.text('Recette enregistrée avec succès !'), findsOneWidget);
    expect(find.text('HomeRoute'), findsOneWidget);
  });
}
