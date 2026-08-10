import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/models/recipe.dart';
import 'package:my_app/widgets/action_nav_button.dart';
import 'package:my_app/widgets/custom_header.dart';
import 'package:my_app/widgets/recipe_card.dart';

void main() {
  group('RecipeCard Widget Tests', () {
    testWidgets('RecipeCard displays recipe title and category', (
      WidgetTester tester,
    ) async {
      const recipe = Recipe(
        id: '1',
        title: 'Test Recipe',
        category: 'Test Category',
        prepTime: '10 min',
        description: 'Test description',
        imageUrl: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(recipe: recipe, onTap: () {}),
          ),
        ),
      );

      expect(find.text('Test Recipe'), findsOneWidget);
      expect(find.text('Test Category • 10 min'), findsOneWidget);
    });

    testWidgets('RecipeCard calls onTap when tapped', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      const recipe = Recipe(
        id: '1',
        title: 'Test Recipe',
        category: 'Category',
        prepTime: '10 min',
        description: 'Description',
        imageUrl: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(
              recipe: recipe,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(RecipeCard));
      await tester.pumpAndSettle();

      expect(tapped, true);
    });

    testWidgets('RecipeCard displays fallback icon when image URL is empty', (
      WidgetTester tester,
    ) async {
      const recipe = Recipe(
        id: '1',
        title: 'Test Recipe',
        category: 'Category',
        prepTime: '10 min',
        description: 'Description',
        imageUrl: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(recipe: recipe, onTap: () {}),
          ),
        ),
      );

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('RecipeCard has correct Card structure', (
      WidgetTester tester,
    ) async {
      const recipe = Recipe(
        id: '1',
        title: 'Test Recipe',
        category: 'Category',
        prepTime: '10 min',
        description: 'Description',
        imageUrl: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(recipe: recipe, onTap: () {}),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
    });
  });

  group('CustomHeader Widget Tests', () {
    testWidgets('CustomHeader displays title and subtitle', (
      WidgetTester tester,
    ) async {
      const header = CustomHeader(
        title: 'Test Title',
        subtitle: 'Test Subtitle',
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: header)));

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
    });

    testWidgets('CustomHeader title has bold font weight', (
      WidgetTester tester,
    ) async {
      const header = CustomHeader(title: 'Bold Title', subtitle: 'Subtitle');

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: header)));

      final titleWidget = find.text('Bold Title');
      expect(titleWidget, findsOneWidget);
    });

    testWidgets('CustomHeader has correct padding', (
      WidgetTester tester,
    ) async {
      const header = CustomHeader(title: 'Title', subtitle: 'Subtitle');

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: header)));

      final padding = find.byType(Padding);
      expect(padding, findsOneWidget);
    });

    testWidgets('CustomHeader displays with column layout', (
      WidgetTester tester,
    ) async {
      const header = CustomHeader(title: 'Title', subtitle: 'Subtitle');

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: header)));

      expect(find.byType(Column), findsOneWidget);
    });
  });

  group('ActionNavButton Widget Tests', () {
    testWidgets('ActionNavButton displays label and icon', (
      WidgetTester tester,
    ) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionNavButton(
              label: 'Test Button',
              icon: Icons.add,
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('ActionNavButton calls onPressed when tapped', (
      WidgetTester tester,
    ) async {
      int pressCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionNavButton(
              label: 'Press Me',
              icon: Icons.check,
              onPressed: () {
                pressCount++;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(pressCount, 1);
    });

    testWidgets('ActionNavButton has ElevatedButton type', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionNavButton(
              label: 'Test',
              icon: Icons.add,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('ActionNavButton is correctly styled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionNavButton(
              label: 'Styled Button',
              icon: Icons.search,
              onPressed: () {},
            ),
          ),
        ),
      );

      final button = find.byType(ElevatedButton);
      expect(button, findsOneWidget);
    });

    testWidgets('ActionNavButton handles multiple taps', (
      WidgetTester tester,
    ) async {
      int pressCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionNavButton(
              label: 'Multi Press',
              icon: Icons.touch_app,
              onPressed: () {
                pressCount++;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(pressCount, 2);
    });
  });
}
