import 'dart:io';

import 'package:cook_book_app/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8DC),
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: Color(0xFFD2691E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Image Preview if available
            recipe.imagePath != null
                ? Image.file(
              File(recipe.imagePath!),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : const Icon(Icons.fastfood, size: 200, color: Colors.grey),
            const SizedBox(height: 16),

            // Ingredients section
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD2691E)),
            ),
            const SizedBox(height: 8),
            Text(recipe.ingredients, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 16),

            // Instructions section
            const Text(
              'Instructions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD2691E)),
            ),
            const SizedBox(height: 8),
            Text(recipe.instructions, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
