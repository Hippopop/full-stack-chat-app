import 'package:json_annotation/json_annotation.dart';

class EpochSecondsDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochSecondsDateTimeConverter();

  @override
  DateTime fromJson(int json) =>
      DateTime.fromMillisecondsSinceEpoch(json * 1000);

  @override
  int toJson(DateTime object) => (object.millisecondsSinceEpoch / 1000).round();
}
