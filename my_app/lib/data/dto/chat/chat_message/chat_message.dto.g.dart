// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageDtoImpl _$$ChatMessageDtoImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageDtoImpl(
      chatRoomId: json['chatRoomId'] as String? ?? '',
      senderUid: json['senderUid'] as String? ?? '',
      message: json['message'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ChatMessageDtoImplToJson(
        _$ChatMessageDtoImpl instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'senderUid': instance.senderUid,
      'message': instance.message,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
