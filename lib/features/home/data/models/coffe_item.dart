import 'package:flutter/foundation.dart';

class CoffeeItem {
  final String id;
  final String name;
  final String description;
  final String image;
  final String category;
  int quantityInCart;
  String uniqueId;
  String selectedSize;
  final String rate;
  final List<Ingredient> ingredients;
  final Map<String, double> sizes;

  CoffeeItem(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.category,
      required this.rate,
      required this.ingredients,
      required this.uniqueId,
      required this.sizes,
      required this.quantityInCart,
      required this.selectedSize});

  factory CoffeeItem.fromMap(Map<String, dynamic> data) {
    return CoffeeItem(
      quantityInCart: data['quantity'] ?? 1,
      selectedSize: data['selectedSize'] ?? 'medium',
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      category: data['category'] ?? '',
      rate: (data['rate'] ?? ''),
      ingredients: (data['ingredients'] as List<dynamic>?)
              ?.map((ingredient) => Ingredient.fromMap(ingredient))
              .toList() ??
          [],
      sizes: (data['sizes'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, (value as num).toDouble()),
          ) ??
          {},
      uniqueId: data['uniqueId'] ?? '',
    );
  }
  toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'category': category,
      'rate': category,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'sizes': sizes.map((key, value) => MapEntry(key, value)),
      'quantity': quantityInCart,
      'selectedSize': selectedSize,
      'uniqueId': uniqueId,
    };
  }
}

class Ingredient {
  final String name;
  final String image;

  Ingredient({
    required this.name,
    required this.image,
  });

  factory Ingredient.fromMap(Map<String, dynamic> data) {
    return Ingredient(
      name: data['name'] ?? '',
      image: data['image'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
