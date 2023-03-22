// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'generated/owner.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Owner extends HiveObject {
  Owner({
    required this.FullName,
    this.Email,
    this.PhoneNo,
    this.ProfilePic,
    this.Location,
  });
  @HiveField(0)
  final String FullName;
  @HiveField(1)
  String? Email;
  @HiveField(2)
  String? PhoneNo;
  @HiveField(3)
  @JsonKey(name: 'profilePic')
  String? ProfilePic;
  @HiveField(4)
  @JsonKey(name: 'location')
  String? Location;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
