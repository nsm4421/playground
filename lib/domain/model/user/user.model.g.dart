// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      email: json['email'] as String?,
      nickname: json['nickname'] as String?,
      sex: $enumDecodeNullable(_$SexEnumMap, json['sex']),
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      profileImageUrls: (json['profileImageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'nickname': instance.nickname,
      'sex': _$SexEnumMap[instance.sex],
      'birthday': instance.birthday?.toIso8601String(),
      'profileImageUrls': instance.profileImageUrls,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$SexEnumMap = {
  Sex.male: 'male',
  Sex.female: 'female',
};
