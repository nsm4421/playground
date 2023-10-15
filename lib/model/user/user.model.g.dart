// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      age: json['age'] as int? ?? -1,
      phone: json['phone'] as String? ?? '',
      city: json['city'] as String? ?? '',
      introduce: json['introduce'] as String? ?? '',
      height: json['height'] as int? ?? -1,
      job: json['job'] as String? ?? '',
      ideal: json['ideal'] as String? ?? '',
      profileImageUrl: json['profileImageUrl'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
      removedAt: json['removedAt'] == null
          ? null
          : DateTime.parse(json['removedAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'nickname': instance.nickname,
      'age': instance.age,
      'phone': instance.phone,
      'city': instance.city,
      'introduce': instance.introduce,
      'height': instance.height,
      'job': instance.job,
      'ideal': instance.ideal,
      'profileImageUrl': instance.profileImageUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'removedAt': instance.removedAt?.toIso8601String(),
    };
