// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryDtoImpl _$$StoryDtoImplFromJson(Map<String, dynamic> json) =>
    _$StoryDtoImpl(
      user: json['user'] == null
          ? const UserDto()
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
      content: json['content'] as String? ?? '',
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$StoryDtoImplToJson(_$StoryDtoImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'content': instance.content,
      'imageUrls': instance.imageUrls,
    };
