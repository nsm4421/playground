// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedDtoImpl _$$FeedDtoImplFromJson(Map<String, dynamic> json) =>
    _$FeedDtoImpl(
      feedId: json['feedId'] as String? ?? '',
      content: json['content'] as String? ?? '',
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      uid: json['uid'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FeedDtoImplToJson(_$FeedDtoImpl instance) =>
    <String, dynamic>{
      'feedId': instance.feedId,
      'content': instance.content,
      'hashtags': instance.hashtags,
      'images': instance.images,
      'uid': instance.uid,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
