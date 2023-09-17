// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../model/feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FeedModel _$$_FeedModelFromJson(Map<String, dynamic> json) => _$_FeedModel(
      feedId: json['feedId'] as String?,
      uid: json['uid'] as String?,
      author: json['author'] as String?,
      content: json['content'] as String?,
      hashtags: json['hashtags'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
      removedAt: json['removedAt'] == null
          ? null
          : DateTime.parse(json['removedAt'] as String),
    );

Map<String, dynamic> _$$_FeedModelToJson(_$_FeedModel instance) =>
    <String, dynamic>{
      'feedId': instance.feedId,
      'uid': instance.uid,
      'author': instance.author,
      'content': instance.content,
      'hashtags': instance.hashtags,
      'image': instance.image,
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'removedAt': instance.removedAt?.toIso8601String(),
    };
