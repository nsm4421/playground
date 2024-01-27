// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDtoImpl _$$UserDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserDtoImpl(
      uid: json['uid'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      email: json['email'] as String? ?? '',
      sex: $enumDecodeNullable(_$SexEnumMap, json['sex']) ?? Sex.male,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      profileImageUrls: (json['profileImageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      description: json['description'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserDtoImplToJson(_$UserDtoImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'email': instance.email,
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
