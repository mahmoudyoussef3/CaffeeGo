// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveItemAdapter extends TypeAdapter<HiveItem> {
  @override
  final int typeId = 0;

  @override
  HiveItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveItem(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      image: fields[3] as String,
      category: fields[4] as String,
      rate: fields[5] as String,
      ingredients: (fields[6] as List).cast<HiveIngredient>(),
      sizes: (fields[7] as Map).cast<String, double>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveItem obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.rate)
      ..writeByte(6)
      ..write(obj.ingredients)
      ..writeByte(7)
      ..write(obj.sizes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveIngredientAdapter extends TypeAdapter<HiveIngredient> {
  @override
  final int typeId = 1;

  @override
  HiveIngredient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveIngredient(
      name: fields[0] as String,
      image: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveIngredient obj) {
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
      other is HiveIngredientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
