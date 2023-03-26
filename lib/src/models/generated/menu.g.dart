// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../menu.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenuCategoryAdapter extends TypeAdapter<MenuCategory> {
  @override
  final int typeId = 6;

  @override
  MenuCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuCategory(
      name: fields[0] as String,
      items: (fields[1] as List?)?.cast<MenuItem>(),
      isExpanded: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MenuCategory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.items)
      ..writeByte(2)
      ..write(obj.isExpanded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MenuItemAdapter extends TypeAdapter<MenuItem> {
  @override
  final int typeId = 7;

  @override
  MenuItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuItem(
      id: fields[0] as String?,
      item: fields[1] as String,
      details: fields[2] as String,
      price: fields[3] as int,
      isVeg: fields[4] as bool,
      isAvailable: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MenuItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.item)
      ..writeByte(2)
      ..write(obj.details)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.isVeg)
      ..writeByte(5)
      ..write(obj.isAvailable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuCategory _$MenuCategoryFromJson(Map<String, dynamic> json) => MenuCategory(
      name: json['Name'] as String,
      items: (json['Items'] as List<dynamic>?)
          ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuCategoryToJson(MenuCategory instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Items': instance.items,
    };

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      id: json['_id'] as String?,
      item: json['ItemName'] as String,
      details: json['Ingredients'] as String,
      price: json['Price'] as int,
      isVeg: json['isVeg'] as bool,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      '_id': instance.id,
      'ItemName': instance.item,
      'Ingredients': instance.details,
      'Price': instance.price,
      'isVeg': instance.isVeg,
      'isAvailable': instance.isAvailable,
    };
