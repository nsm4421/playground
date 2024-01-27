// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_comment.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedCommentModelImpl _$$FeedCommentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FeedCommentModelImpl(
      commentId: json['commentId'] as String?,
      feedId: json['feedId'] as String?,
      content: json['content'] as String?,
      uid: json['uid'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FeedCommentModelImplToJson(
        _$FeedCommentModelImpl instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'feedId': instance.feedId,
      'content': instance.content,
      'uid': instance.uid,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
