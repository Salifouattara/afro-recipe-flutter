import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/add_recipe_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: '/add',
          builder: (context, state) => const AddRecipeScreen(),
        ),
        GoRoute(
          path: '/detail/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            return DetailScreen(recipeId: id);
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'My Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
