// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../list_place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListPlaceModelAdapter extends TypeAdapter<ListPlaceModel> {
  @override
  final int typeId = 1;

  @override
  ListPlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListPlaceModel(
      placeName: fields[0] as String,
      address: fields[1] as String,
      ownerName: fields[2] as String,
      status: fields[3] as ListPlaceStatus?,
      document: fields[4] as dynamic,
      foodPlaceId: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ListPlaceModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.placeName)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.ownerName)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.document)
      ..writeByte(5)
      ..write(obj.foodPlaceId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListPlaceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ListPlaceStatusAdapter extends TypeAdapter<ListPlaceStatus> {
  @override
  final int typeId = 2;

  @override
  ListPlaceStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ListPlaceStatus.verified;
      case 1:
        return ListPlaceStatus.unverified;
      case 2:
        return ListPlaceStatus.verifying;
      default:
        return ListPlaceStatus.verified;
    }
  }

  @override
  void write(BinaryWriter writer, ListPlaceStatus obj) {
    switch (obj) {
      case ListPlaceStatus.verified:
        writer.writeByte(0);
        break;
      case ListPlaceStatus.unverified:
        writer.writeByte(1);
        break;
      case ListPlaceStatus.verifying:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListPlaceStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPlaceModel _$ListPlaceModelFromJson(Map<String, dynamic> json) =>
    ListPlaceModel(
      placeName: json['PlaceName'] as String,
      address: json['Address'] as String,
      ownerName: json['OwnerName'] as String,
      status: $enumDecodeNullable(_$ListPlaceStatusEnumMap, json['status']),
      document: json['document'],
      foodPlaceId: json['foodPlace'] as String?,
    );

Map<String, dynamic> _$ListPlaceModelToJson(ListPlaceModel instance) =>
    <String, dynamic>{
      'PlaceName': instance.placeName,
      'Address': instance.address,
      'OwnerName': instance.ownerName,
      'status': _$ListPlaceStatusEnumMap[instance.status],
      'document': instance.document,
      'foodPlace': instance.foodPlaceId,
    };

const _$ListPlaceStatusEnumMap = {
  ListPlaceStatus.verified: 'verified',
  ListPlaceStatus.unverified: 'unverified',
  ListPlaceStatus.verifying: 'verifying',
};
