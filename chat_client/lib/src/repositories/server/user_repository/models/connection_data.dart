import 'package:chat_client/src/constants/utils/json_date_convert.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_data.freezed.dart';
part 'connection_data.g.dart';

enum ConnectionStatus {
  requested,
  accepted,
  rejected,
  blocked,
}

@freezed
class ConnectionData with _$ConnectionData {
  const factory ConnectionData({
    String? acceptTime,
    @EpochSecondsDateTimeConverter() DateTime? createdAt,
    @EpochSecondsDateTimeConverter() DateTime? updatedAt,
    required int key,
    required String toUser,
    required String fromUser,
    required ConnectionStatus connectionStatus,
  }) = _ConnectionData;

  const ConnectionData._();

  factory ConnectionData.fromJson(Map<String, Object?> json) =>
      _$ConnectionDataFromJson(json);
}
