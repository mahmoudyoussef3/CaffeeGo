import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:hive/hive.dart';

part 'hive_item.g.dart';

@HiveType(typeId: 0)
class HiveItem extends HiveObject {
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
  final String rate;

  @HiveField(6)
  final List<HiveIngredient> ingredients;

  @HiveField(7)
  final Map<String, double> sizes;

  HiveItem({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.rate,
    required this.ingredients,
    required this.sizes,
  });
}

@HiveType(typeId: 1)
class HiveIngredient extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String image;

  HiveIngredient({
    required this.name,
    required this.image,
  });
}
