import 'package:cook_book_app/screens/recipe_details.dart';
import 'package:flutter/material.dart';
import 'package:cook_book_app/models/recipe.dart';
import 'package:cook_book_app/recipe_search_delegate.dart';

import '../helpers/database_helper.dart';  // Import your search delegate

class RecipeLibraryScreen extends StatefulWidget {
  const RecipeLibraryScreen({Key? key}) : super(key: key);

  @override
  _RecipeLibraryScreenState createState() => _RecipeLibraryScreenState();
}

class _RecipeLibraryScreenState extends State<RecipeLibraryScreen> {
  late Future<List<Recipe>> _recipes;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  void _loadRecipes() {
    setState(() {
      _recipes = DatabaseHelper.instance.getAllRecipes(); // Fetch recipes from the database
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8DC),
      appBar: AppBar(
        title: const Text('Recipe Library'),
        backgroundColor: Color(0xFFD2691E),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              // Fetch the data from the Future before triggering search
              final List<Recipe> recipes = await _recipes;
              showSearch(
                context: context,
                delegate: RecipeSearchDelegate(allRecipes: recipes), // Pass the fetched data to the search delegate
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _recipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes available.'));
          }

          final recipes = snapshot.data!;

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return ListTile(
                title: Text(recipe.name),
                subtitle: Text(recipe.ingredients),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailsScreen(recipe: recipe),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFD2691E),
        onPressed: () async {
          await Navigator.pushNamed(context, '/add_recipe');
          _loadRecipes();  // Reload the recipes after adding a new one
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
