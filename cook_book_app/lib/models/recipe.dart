class Recipe {
  final int? id;
  final String name;
  final String ingredients;
  final String instructions;
  final String? imagePath;

  Recipe({
    this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    this.imagePath,
  });

  // Convert a Recipe object to a map (for saving in database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
      'imagePath': imagePath,
    };
  }

  // Convert a map to a Recipe object
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      ingredients: map['ingredients'],
      instructions: map['instructions'],
      imagePath: map['imagePath'],
    );
  }
}
