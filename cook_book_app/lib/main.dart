import 'package:cook_book_app/screens/add_recipe.dart';
import 'package:flutter/material.dart';
import 'screens/recipe_library.dart';

void main() {
  runApp(const CookBookApp());
}

class CookBookApp extends StatelessWidget {
  const CookBookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookBook Recipe Manager',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFFD2691E),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RecipeLibraryScreen(),
        '/add_recipe': (context) => const AddRecipeScreen(),
      },
    );
  }
}