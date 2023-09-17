// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../model/user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as String?,
      username: json['username'] as String?,
      description: json['description'] as String?,
      profileUrl: json['profileUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
      removedAt: json['removedAt'] == null
          ? null
          : DateTime.parse(json['removedAt'] as String),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'description': instance.description,
      'profileUrl': instance.profileUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastSeen': instance.lastSeen?.toIso8601String(),
      'removedAt': instance.removedAt?.toIso8601String(),
    };
