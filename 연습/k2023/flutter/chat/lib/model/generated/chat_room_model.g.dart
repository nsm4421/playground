// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatRoomModel _$$_ChatRoomModelFromJson(Map<String, dynamic> json) =>
    _$_ChatRoomModel(
      chatRoomId: json['chatRoomId'] as String?,
      chatRoomName: json['chatRoomName'] as String?,
      host: json['host'] as String?,
      uidList: (json['uidList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      removedAt: json['removedAt'] == null
          ? null
          : DateTime.parse(json['removedAt'] as String),
    );

Map<String, dynamic> _$$_ChatRoomModelToJson(_$_ChatRoomModel instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'chatRoomName': instance.chatRoomName,
      'host': instance.host,
      'uidList': instance.uidList,
      'hashtags': instance.hashtags,
      'createdAt': instance.createdAt?.toIso8601String(),
      'removedAt': instance.removedAt?.toIso8601String(),
    };
