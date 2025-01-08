import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_message.freezed.dart';
part 'user_message.g.dart';

enum MessageState {
  error,
  loading,
  sent,
  delivered,
  seen,
}

@freezed
class UserMessage with _$UserMessage {
  const factory UserMessage({
    required int key,
    required int connection,
    required String sender,
    required String receiver,
    String? text,
    String? parent,
    String? voiceNote,
    int? createdAt,
    int? updatedAt,
    int? deliverTime,
    int? seenTime,
  }) = _UserMessage;

  const UserMessage._();

  MessageState get state {
    if (seenTime != null) return MessageState.seen;
    if (deliverTime != null) return MessageState.delivered;
    if (createdAt != null) return MessageState.sent;
    return MessageState.loading;
  }

  factory UserMessage.fromJson(Map<String, Object?> json) =>
      _$UserMessageFromJson(json);
}

@freezed
class MessageAttachments with _$MessageAttachments {
  const factory MessageAttachments({
    required List<String> picture,
    required List<String> video,
  }) = _MessageAttachments;

  factory MessageAttachments.fromJson(Map<String, Object?> json) =>
      _$MessageAttachmentsFromJson(json);
}
