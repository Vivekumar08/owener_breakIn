// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rate _$RateFromJson(Map<String, dynamic> json) => Rate(
      name: json['Name'] as String,
      date: Rate.timestampsToDate(json['createdAt'] as String),
      overallRating: (json['OverallRating'] as num).toDouble(),
      hygiene: json['Hygiene'] as int,
      taste: json['Taste'] as int,
      quality: json['Quality'] as int,
      ambience: json['Ambience'] as int,
      comment: json['Comment'] as String,
    );

Map<String, dynamic> _$RateToJson(Rate instance) => <String, dynamic>{
      'Name': instance.name,
      'createdAt': instance.date,
      'OverallRating': instance.overallRating,
      'Hygiene': instance.hygiene,
      'Taste': instance.taste,
      'Quality': instance.quality,
      'Ambience': instance.ambience,
      'Comment': instance.comment,
    };
