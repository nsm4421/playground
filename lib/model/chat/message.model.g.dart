// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      messageId: json['messageId'] as String? ?? '',
      chatRoomId: json['chatRoomId'] as String? ?? '',
      senderUid: json['senderUid'] as String? ?? '',
      content: json['content'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      removedAt: json['removedAt'] == null
          ? null
          : DateTime.parse(json['removedAt'] as String),
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'chatRoomId': instance.chatRoomId,
      'senderUid': instance.senderUid,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'removedAt': instance.removedAt?.toIso8601String(),
    };
