import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'generated/list_place.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class ListPlaceModel extends HiveObject {
  ListPlaceModel({
    required this.placeName,
    required this.address,
    required this.ownerName,
    this.status,
    this.document,
    this.foodPlaceId,
  });

  @HiveField(0)
  @JsonKey(name: 'PlaceName')
  final String placeName;

  @HiveField(1)
  @JsonKey(name: 'Address')
  final String address;

  @HiveField(2)
  @JsonKey(name: 'OwnerName')
  final String ownerName;

  @HiveField(3)
  ListPlaceStatus? status;

  @HiveField(4)
  dynamic document;

  @HiveField(5)
  @JsonKey(name: 'foodPlace')
  String? foodPlaceId;

  factory ListPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$ListPlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListPlaceModelToJson(this);
}

// Hive don't accept cuustom datatypes
@HiveType(typeId: 2)
enum ListPlaceStatus {
  @HiveField(0)
  verified,

  @HiveField(1)
  unverified,

  @HiveField(2)
  verifying
}
