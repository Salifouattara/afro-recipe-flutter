import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:my_app/screens/add_recipe_screen.dart';
import 'package:my_app/screens/search_screen.dart';

void main() {
  group('Screen Classes Verification', () {
    test('SearchScreen is a StatefulWidget', () {
      final screen = SearchScreen();
      expect(screen, isA<StatefulWidget>());
    });

    test('AddRecipeScreen is a StatefulWidget', () {
      final screen = const AddRecipeScreen();
      expect(screen, isA<StatefulWidget>());
    });
  });

  group('AddRecipeScreen Integration Tests', () {
    testWidgets('AddRecipeScreen displays form fields', (
      WidgetTester tester,
    ) async {
      final router = GoRouter(
        initialLocation: '/add',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('HomeRoute'))),
          ),
          GoRoute(
            path: '/add',
            builder: (context, state) => const AddRecipeScreen(),
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('AddRecipeScreen has title', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: '/add',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('HomeRoute'))),
          ),
          GoRoute(
            path: '/add',
            builder: (context, state) => const AddRecipeScreen(),
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      expect(find.text('Ajouter une recette'), findsOneWidget);
    });

    testWidgets('AddRecipeScreen has submit button', (
      WidgetTester tester,
    ) async {
      final router = GoRouter(
        initialLocation: '/add',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('HomeRoute'))),
          ),
          GoRoute(
            path: '/add',
            builder: (context, state) => const AddRecipeScreen(),
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      expect(find.text('Enregistrer la recette'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('AddRecipeScreen validates empty form', (
      WidgetTester tester,
    ) async {
      final router = GoRouter(
        initialLocation: '/add',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('HomeRoute'))),
          ),
          GoRoute(
            path: '/add',
            builder: (context, state) => const AddRecipeScreen(),
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Enregistrer la recette'));
      await tester.pumpAndSettle();

      expect(find.text('Veuillez saisir un titre.'), findsOneWidget);
    });

    testWidgets('AddRecipeScreen validates partial form submission', (
      WidgetTester tester,
    ) async {
      final router = GoRouter(
        initialLocation: '/add',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('HomeRoute'))),
          ),
          GoRoute(
            path: '/add',
            builder: (context, state) => const AddRecipeScreen(),
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('titleField')),
        'Test Recipe',
      );
      await tester.tap(find.text('Enregistrer la recette'));
      await tester.pumpAndSettle();

      expect(find.text('Veuillez saisir une catégorie.'), findsOneWidget);
    });
  });
}
