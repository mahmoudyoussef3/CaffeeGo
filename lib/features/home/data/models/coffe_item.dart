class CoffeeItem {
  final String id;
  final String name;
  final String description;
  final String image;
  final String category;
  final double rate;
  final List<Ingredient> ingredients;
  final Map<String, double> sizes; // New field for sizes

  CoffeeItem({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.rate,
    required this.ingredients,
    required this.sizes,
  });

  // Factory method to create a CoffeeItem from a Firestore document
  factory CoffeeItem.fromMap(Map<String, dynamic> data) {
    return CoffeeItem(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      category: data['category'] ?? '',
      rate: (data['rate'] ?? 0.0).toDouble(),
      ingredients: (data['ingredients'] as List<dynamic>?)
          ?.map((ingredient) => Ingredient.fromMap(ingredient))
          .toList() ??
          [],
      sizes: (data['sizes'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, (value as num).toDouble()),
      ) ??
          {}, // Convert Firestore map to Map<String, double>
    );
  }
}

class Ingredient {
  final String name;
  final String image;

  Ingredient({
    required this.name,
    required this.image,
  });

  // Factory method to create Ingredient from a map
  factory Ingredient.fromMap(Map<String, dynamic> data) {
    return Ingredient(
      name: data['name'] ?? '',
      image: data['image'] ?? '',
    );
  }
}
