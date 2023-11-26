// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedModelImpl _$$FeedModelImplFromJson(Map<String, dynamic> json) =>
    _$FeedModelImpl(
      feedId: json['feedId'] as String?,
      content: json['content'] as String?,
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      uid: json['uid'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FeedModelImplToJson(_$FeedModelImpl instance) =>
    <String, dynamic>{
      'feedId': instance.feedId,
      'content': instance.content,
      'hashtags': instance.hashtags,
      'images': instance.images,
      'uid': instance.uid,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
