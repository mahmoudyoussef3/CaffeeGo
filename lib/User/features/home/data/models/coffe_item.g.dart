// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffe_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoffeeItemAdapter extends TypeAdapter<CoffeeItem> {
  @override
  final int typeId = 0;

  @override
  CoffeeItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoffeeItem(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      image: fields[3] as String,
      category: fields[4] as String,
      rate: fields[8] as String,
      ingredients: (fields[9] as List).cast<Ingredient>(),
      uniqueId: fields[6] as String,
      sizes: (fields[10] as Map).cast<String, double>(),
      quantityInCart: fields[5] as int,
      selectedSize: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CoffeeItem obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.quantityInCart)
      ..writeByte(6)
      ..write(obj.uniqueId)
      ..writeByte(7)
      ..write(obj.selectedSize)
      ..writeByte(8)
      ..write(obj.rate)
      ..writeByte(9)
      ..write(obj.ingredients)
      ..writeByte(10)
      ..write(obj.sizes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoffeeItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IngredientAdapter extends TypeAdapter<Ingredient> {
  @override
  final int typeId = 1;

  @override
  Ingredient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ingredient(
      name: fields[0] as String,
      image: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ingredient obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
