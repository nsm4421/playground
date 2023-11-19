// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDtoImpl _$$UserDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserDtoImpl(
      nickname: json['nickname'] as String? ?? '',
      email: json['email'] as String? ?? '',
      sex: $enumDecodeNullable(_$SexEnumMap, json['sex']) ?? Sex.male,
      age: json['age'] as int? ?? -1,
      profileImageUrl: json['profileImageUrl'] as String? ?? '',
      description: json['description'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserDtoImplToJson(_$UserDtoImpl instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'email': instance.email,
      'sex': _$SexEnumMap[instance.sex]!,
      'age': instance.age,
      'profileImageUrl': instance.profileImageUrl,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$SexEnumMap = {
  Sex.male: 'male',
  Sex.female: 'female',
};
