// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryModelImpl _$$StoryModelImplFromJson(Map<String, dynamic> json) =>
    _$StoryModelImpl(
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      content: json['content'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$StoryModelImplToJson(_$StoryModelImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
    };
