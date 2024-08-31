// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserMessageImpl _$$UserMessageImplFromJson(Map<String, dynamic> json) =>
    _$UserMessageImpl(
      key: (json['key'] as num).toInt(),
      connection: (json['connection'] as num).toInt(),
      sender: json['sender'] as String,
      receiver: json['receiver'] as String,
      text: json['text'] as String?,
      parent: json['parent'] as String?,
      voiceNote: json['voiceNote'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      updatedAt: (json['updatedAt'] as num?)?.toInt(),
      deliverTime: (json['deliverTime'] as num?)?.toInt(),
      seenTime: (json['seenTime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UserMessageImplToJson(_$UserMessageImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'connection': instance.connection,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'text': instance.text,
      'parent': instance.parent,
      'voiceNote': instance.voiceNote,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'deliverTime': instance.deliverTime,
      'seenTime': instance.seenTime,
    };

_$MessageAttachmentsImpl _$$MessageAttachmentsImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageAttachmentsImpl(
      picture:
          (json['picture'] as List<dynamic>).map((e) => e as String).toList(),
      video: (json['video'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$MessageAttachmentsImplToJson(
        _$MessageAttachmentsImpl instance) =>
    <String, dynamic>{
      'picture': instance.picture,
      'video': instance.video,
    };
