// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      nickname: json['nickname'] as String?,
      age: json['age'] as int?,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'age': instance.age,
      'profileImageUrl': instance.profileImageUrl,
    };
