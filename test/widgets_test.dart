import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/widgets/recipe_card.dart';
import 'package:my_app/models/recipe.dart';

void main() {
  testWidgets('RecipeCard displays recipe title and category', (WidgetTester tester) async {
    const recipe = Recipe(
      id: '1',
      title: 'Test Recipe',
      category: 'Test Category',
      prepTime: '10 min',
      description: 'Test description',
      imageUrl: '',
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RecipeCard(
          recipe: recipe,
          onTap: () {},
        ),
      ),
    ));

    expect(find.text('Test Recipe'), findsOneWidget);
    expect(find.text('Test Category • 10 min'), findsOneWidget);
  });
}
