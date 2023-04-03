import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'generated/owner.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Owner extends HiveObject {
  Owner({
    required this.fullName,
    this.email,
    this.phoneNo,
    this.profilePic,
    this.location,
  });

  @HiveField(0)
  @JsonKey(name: 'FullName')
  final String fullName;

  @HiveField(1)
  @JsonKey(name: 'Email')
  String? email;

  @HiveField(2)
  @JsonKey(name: 'PhoneNo')
  String? phoneNo;

  @HiveField(3)
  String? profilePic;

  @HiveField(4)
  String? location;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
