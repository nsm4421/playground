// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomDtoImpl _$$ChatRoomDtoImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomDtoImpl(
      chatRoomId: json['chatRoomId'] as String? ?? '',
      chatRoomName: json['chatRoomName'] as String? ?? '',
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      uidList: (json['uidList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      hostUid: json['hostUid'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ChatRoomDtoImplToJson(_$ChatRoomDtoImpl instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'chatRoomName': instance.chatRoomName,
      'hashtags': instance.hashtags,
      'uidList': instance.uidList,
      'hostUid': instance.hostUid,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
