// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageModel _$$_MessageModelFromJson(Map<String, dynamic> json) =>
    _$_MessageModel(
      messageId: json['messageId'] as String?,
      chatRoomId: json['chatRoomId'] as String?,
      senderUid: json['senderUid'] as String?,
      message: json['message'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      removedAt: json['removedAt'] == null
          ? null
          : DateTime.parse(json['removedAt'] as String),
    );

Map<String, dynamic> _$$_MessageModelToJson(_$_MessageModel instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'chatRoomId': instance.chatRoomId,
      'senderUid': instance.senderUid,
      'message': instance.message,
      'image': instance.image,
      'createdAt': instance.createdAt?.toIso8601String(),
      'removedAt': instance.removedAt?.toIso8601String(),
    };
