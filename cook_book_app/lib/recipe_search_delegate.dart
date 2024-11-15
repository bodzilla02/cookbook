import 'package:cook_book_app/models/recipe.dart';
import 'package:cook_book_app/screens/recipe_details.dart';
import 'package:flutter/material.dart';

class RecipeSearchDelegate extends SearchDelegate {
  final List<Recipe> allRecipes;

  RecipeSearchDelegate({required this.allRecipes});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the query when the clear button is pressed
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search when the back button is pressed
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filter results based on query (search by name or ingredients)
    final results = allRecipes.where((recipe) {
      return recipe.name.toLowerCase().contains(query.toLowerCase()) ||
          recipe.ingredients.toLowerCase().contains(query.toLowerCase());
    }).toList();

    // If no results found, show a message
    if (results.isEmpty) {
      return const Center(child: Text('No results found.'));
    }

    // Display the filtered results
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final recipe = results[index];
        return ListTile(
          title: Text(recipe.name),
          subtitle: Text(recipe.ingredients),
          onTap: () {
            close(context, recipe); // Close search and return the selected recipe
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
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions based on the query
    final suggestions = allRecipes.where((recipe) {
      return recipe.name.toLowerCase().contains(query.toLowerCase()) ||
          recipe.ingredients.toLowerCase().contains(query.toLowerCase());
    }).toList();

    // Display suggestions if the user has typed something
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final recipe = suggestions[index];
        return ListTile(
          title: Text(recipe.name),
          subtitle: Text(recipe.ingredients),
          onTap: () {
            close(context, recipe); // Close search and return the selected recipe
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
  }
}
