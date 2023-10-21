// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomModelImpl _$$ChatRoomModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomModelImpl(
      chatRoomId: json['chatRoomId'] as String? ?? '',
      chatRoomName: json['chatRoomName'] as String? ?? '',
      hostUserId: json['hostUserId'] as String? ?? '',
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      removedAt: json['removedAt'] == null
          ? null
          : DateTime.parse(json['removedAt'] as String),
    );

Map<String, dynamic> _$$ChatRoomModelImplToJson(_$ChatRoomModelImpl instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'chatRoomName': instance.chatRoomName,
      'hostUserId': instance.hostUserId,
      'hashtags': instance.hashtags,
      'createdAt': instance.createdAt?.toIso8601String(),
      'removedAt': instance.removedAt?.toIso8601String(),
    };
