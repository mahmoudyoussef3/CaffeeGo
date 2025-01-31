import 'package:hive/hive.dart';
part 'coffe_item.g.dart';
@HiveType(typeId: 0)
class CoffeeItem extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final String category;
  @HiveField(5)
  int quantityInCart;
  @HiveField(6)
  String uniqueId;
  @HiveField(7)
  String selectedSize;
  @HiveField(8)
  final String rate;
  @HiveField(9)
  final List<Ingredient> ingredients;
  @HiveField(10)
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
      'rate': rate,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'sizes': sizes.map((key, value) => MapEntry(key, value)),
      'quantity': quantityInCart,
      'selectedSize': selectedSize,
      'uniqueId': uniqueId,
    };
  }
}

@HiveType(typeId: 1)
class Ingredient extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
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
