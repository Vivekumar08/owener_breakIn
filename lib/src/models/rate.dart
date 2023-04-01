import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'generated/rate.g.dart';

@JsonSerializable()
class Rate {
  const Rate({
    required this.name,
    required this.date,
    required this.overallRating,
    required this.hygiene,
    required this.taste,
    required this.quality,
    required this.ambience,
    required this.comment,
  });

  @JsonKey(name: "Name")
  final String name;

  @JsonKey(name: "createdAt", fromJson: timestampsToDate)
  final String date;

  @JsonKey(name: "OverallRating")
  final double overallRating;

  @JsonKey(name: "Hygiene")
  final int hygiene;

  @JsonKey(name: "Taste")
  final int taste;

  @JsonKey(name: "Quality")
  final int quality;

  @JsonKey(name: "Ambience")
  final int ambience;

  @JsonKey(name: "Comment")
  final String comment;

  static String timestampsToDate(String value) {
    DateTime? dateTime = DateTime.now();
    if (value.isNotEmpty) {
      try {
        dateTime =
            DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(value, false).toLocal();
        return DateFormat.yMMMMd().format(dateTime);
      } catch (_) {}
    }
    return 'date';
  }

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);

  Map<String, dynamic> toJson() => _$RateToJson(this);
}
