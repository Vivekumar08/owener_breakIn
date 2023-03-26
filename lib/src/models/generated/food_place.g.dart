// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../food_place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodPlaceModelAdapter extends TypeAdapter<FoodPlaceModel> {
  @override
  final int typeId = 3;

  @override
  FoodPlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodPlaceModel(
      id: fields[0] as String,
      name: fields[1] as String,
      status: fields[2] as bool,
      category: fields[3] as FoodPlaceCategory,
      foodType: fields[4] as String,
      image: fields[5] as String,
      location: fields[6] as Location,
      menu: (fields[7] as List?)?.cast<MenuCategory>(),
      rating: fields[8] as double?,
      ratedBy: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FoodPlaceModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.foodType)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.menu)
      ..writeByte(8)
      ..write(obj.rating)
      ..writeByte(9)
      ..write(obj.ratedBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodPlaceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 5;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      lat: fields[0] as double,
      lng: fields[1] as double,
      address: fields[2] as String,
      landmark: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lng)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.landmark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FoodPlaceCategoryAdapter extends TypeAdapter<FoodPlaceCategory> {
  @override
  final int typeId = 4;

  @override
  FoodPlaceCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FoodPlaceCategory.Canteen;
      case 1:
        return FoodPlaceCategory.Mess;
      case 2:
        return FoodPlaceCategory.Micro_Cafe;
      case 3:
        return FoodPlaceCategory.Juice_Corner;
      case 4:
        return FoodPlaceCategory.Diary_Booth;
      default:
        return FoodPlaceCategory.Canteen;
    }
  }

  @override
  void write(BinaryWriter writer, FoodPlaceCategory obj) {
    switch (obj) {
      case FoodPlaceCategory.Canteen:
        writer.writeByte(0);
        break;
      case FoodPlaceCategory.Mess:
        writer.writeByte(1);
        break;
      case FoodPlaceCategory.Micro_Cafe:
        writer.writeByte(2);
        break;
      case FoodPlaceCategory.Juice_Corner:
        writer.writeByte(3);
        break;
      case FoodPlaceCategory.Diary_Booth:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodPlaceCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodPlaceModel _$FoodPlaceModelFromJson(Map<String, dynamic> json) =>
    FoodPlaceModel(
      id: json['foodPlaceId'] as String,
      name: json['FoodPlaceName'] as String,
      status: json['status'] as bool,
      category: $enumDecode(_$FoodPlaceCategoryEnumMap, json['category']),
      foodType: json['type'] as String,
      image: json['CoverPhoto'] as String,
      location: Location.fromJson(json['Locations'] as Map<String, dynamic>),
      menu: (json['Menu'] as List<dynamic>?)
          ?.map((e) => MenuCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      rating: (json['Ratings'] as num?)?.toDouble(),
      ratedBy: json['RatedBy'] as int,
    );

Map<String, dynamic> _$FoodPlaceModelToJson(FoodPlaceModel instance) =>
    <String, dynamic>{
      'foodPlaceId': instance.id,
      'FoodPlaceName': instance.name,
      'status': instance.status,
      'category': _$FoodPlaceCategoryEnumMap[instance.category]!,
      'type': instance.foodType,
      'CoverPhoto': instance.image,
      'Locations': instance.location,
      'Menu': instance.menu,
      'Ratings': instance.rating,
      'RatedBy': instance.ratedBy,
    };

const _$FoodPlaceCategoryEnumMap = {
  FoodPlaceCategory.Canteen: 'Canteen',
  FoodPlaceCategory.Mess: 'Mess',
  FoodPlaceCategory.Micro_Cafe: 'Micro_Cafe',
  FoodPlaceCategory.Juice_Corner: 'Juice_Corner',
  FoodPlaceCategory.Diary_Booth: 'Diary_Booth',
};

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      address: json['address'] as String,
      landmark: json['landmark'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'address': instance.address,
      'landmark': instance.landmark,
    };
