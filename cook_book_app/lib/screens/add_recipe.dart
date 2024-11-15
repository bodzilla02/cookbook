import 'package:cook_book_app/helpers/database_helper.dart';
import 'package:cook_book_app/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<void> _saveRecipe() async {
    final newRecipe = Recipe(
      name: _nameController.text,
      ingredients: _ingredientsController.text,
      instructions: _instructionsController.text,
      imagePath: _image?.path,
    );

    // Add the new recipe to the database
    await DatabaseHelper.instance.addRecipe(newRecipe);

    // After saving, pop the current screen (Add Recipe Screen) and return to the previous screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8DC),
      appBar: AppBar(
        title: const Text('Add Recipe'),
        backgroundColor: Color(0xFFD2691E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Image Preview if available
            _image != null
                ? Column(
              children: [
                Image.file(
                  File(_image!.path),
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                const Text('Image selected'),
              ],
            )
                : const Text('No image selected'),
            const SizedBox(height: 16),

            // Recipe Name TextField
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Recipe Name',
                labelStyle: TextStyle(color: Color(0xFFD2691E)),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Ingredients TextField
            TextField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                labelText: 'Ingredients',
                labelStyle: TextStyle(color: Color(0xFFD2691E)),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Instructions TextField
            TextField(
              controller: _instructionsController,
              decoration: const InputDecoration(
                labelText: 'Instructions',
                labelStyle: TextStyle(color: Color(0xFFD2691E)),
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),

            // Save Recipe Button
            ElevatedButton(
              onPressed: _saveRecipe,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFA07A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Save Recipe',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // Pick Image Button
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFA07A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Pick an Image',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
