import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'generated/menu.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class MenuCategory extends HiveObject {
  MenuCategory({
    required this.name,
    required this.items,
    this.isExpanded = false,
    required this.foodPlaceId,
  });

  @HiveField(0)
  @JsonKey(name: 'Name')
  final String name;

  @HiveField(1)
  @JsonKey(name: 'Items')
  final List<MenuItem> items;

  @HiveField(2)
  @JsonKey(includeToJson: false, includeFromJson: false)
  bool isExpanded;

  @HiveField(3)
  @JsonKey(name: 'foodPlace')
  final String foodPlaceId;

  factory MenuCategory.fromJson(Map<String, dynamic> json) =>
      _$MenuCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MenuCategoryToJson(this);
}

@HiveType(typeId: 7)
@JsonSerializable()
class MenuItem extends HiveObject {
  MenuItem({
    this.id,
    required this.item,
    required this.details,
    required this.price,
    required this.isVeg,
    this.isAvailable = true,
  });

  @HiveField(0)
  @JsonKey(name: '_id')
  final String? id;

  @HiveField(1)
  @JsonKey(name: 'ItemName')
  final String item;

  @HiveField(2)
  @JsonKey(name: 'Ingredients')
  final String details;

  @HiveField(3)
  @JsonKey(name: 'Name')
  final int price;

  @HiveField(4)
  final bool isVeg;

  @HiveField(5)
  final bool isAvailable;

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}
