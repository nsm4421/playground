// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_module.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ViewModuleDtoImpl _$$ViewModuleDtoImplFromJson(Map<String, dynamic> json) =>
    _$ViewModuleDtoImpl(
      type: $enumDecodeNullable(_$ViewModuleTypeEnumMap, json['type']) ??
          ViewModuleType.none,
      user: json['user'] == null
          ? const UserDto()
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
      content: json['content'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );

Map<String, dynamic> _$$ViewModuleDtoImplToJson(_$ViewModuleDtoImpl instance) =>
    <String, dynamic>{
      'type': _$ViewModuleTypeEnumMap[instance.type],
      'user': instance.user,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
    };

const _$ViewModuleTypeEnumMap = {
  ViewModuleType.story: 'story',
  ViewModuleType.none: 'none',
};
