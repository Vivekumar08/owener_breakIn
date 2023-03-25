// ignore_for_file: constant_identifier_names
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'generated/food_place.g.dart';

// Hive don't accept cuustom datatypes
@HiveType(typeId: 4)
enum FoodPlaceCategory {
  @HiveField(0)
  Canteen,

  @HiveField(1)
  Mess,

  @HiveField(2)
  Micro_Cafe,

  @HiveField(3)
  Juice_Corner,

  @HiveField(4)
  Diary_Booth
}

@HiveType(typeId: 3)
@JsonSerializable()
class FoodPlaceModel extends HiveObject {
  FoodPlaceModel({
    required this.name,
    required this.id,
    required this.status,
    required this.category,
    required this.foodType,
    required this.image,
    required this.location,
    required this.menu,
    required this.rating,
    required this.ratedBy,
  });

  @HiveField(0)
  @JsonKey(name: 'FoodPlaceName')
  final String name;

  @HiveField(1)
  @JsonKey(name: 'foodPlaceId')
  final String id;

  @HiveField(2)
  final bool status;

  @HiveField(3)
  @JsonKey()
  final FoodPlaceCategory category;

  @HiveField(4)
  @JsonKey(name: 'type')
  final String foodType;

  @HiveField(5)
  @JsonKey(name: 'CoverPhoto')
  final String image;

  @HiveField(6)
  @JsonKey(name: 'Locations')
  final Location location;

  @HiveField(7)
  @JsonKey(name: 'Menu')
  final String menu;

  @HiveField(8)
  @JsonKey(name: 'Ratings')
  final double rating;

  @HiveField(9)
  @JsonKey(name: 'RatedBy')
  final int ratedBy;

  factory FoodPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$FoodPlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoodPlaceModelToJson(this);
}

@HiveType(typeId: 5)
@JsonSerializable()
class Location {
  Location({
    required this.lat,
    required this.lng,
    required this.address,
    this.landmark,
  });

  @HiveField(0)
  final double lat;

  @HiveField(1)
  final double lng;

  @HiveField(2)
  final String address;

  @HiveField(3)
  final String? landmark;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}