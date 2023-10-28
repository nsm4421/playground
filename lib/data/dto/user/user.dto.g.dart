// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDtoImpl _$$UserDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserDtoImpl(
      nickname: json['nickname'] as String? ?? '',
      age: json['age'] as int? ?? -1,
      profileImageUrl: json['profileImageUrl'] as String? ?? '',
    );

Map<String, dynamic> _$$UserDtoImplToJson(_$UserDtoImpl instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'age': instance.age,
      'profileImageUrl': instance.profileImageUrl,
    };
