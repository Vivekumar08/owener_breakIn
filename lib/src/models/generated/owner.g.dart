// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../owner.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OwnerAdapter extends TypeAdapter<Owner> {
  @override
  final int typeId = 0;

  @override
  Owner read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Owner(
      fullName: fields[0] as String,
      email: fields[1] as String?,
      phoneNo: fields[2] as String?,
      profilePic: fields[3] as String?,
      location: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Owner obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phoneNo)
      ..writeByte(3)
      ..write(obj.profilePic)
      ..writeByte(4)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      fullName: json['FullName'] as String,
      email: json['Email'] as String?,
      phoneNo: json['PhoneNo'] as String?,
      profilePic: json['profilePic'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'FullName': instance.fullName,
      'Email': instance.email,
      'PhoneNo': instance.phoneNo,
      'profilePic': instance.profilePic,
      'location': instance.location,
    };
