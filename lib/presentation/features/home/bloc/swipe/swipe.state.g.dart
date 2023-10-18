// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swipe.state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SwipeStateImpl _$$SwipeStateImplFromJson(Map<String, dynamic> json) =>
    _$SwipeStateImpl(
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ??
          Status.initial,
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <UserModel>[],
    );

Map<String, dynamic> _$$SwipeStateImplToJson(_$SwipeStateImpl instance) =>
    <String, dynamic>{
      'status': _$StatusEnumMap[instance.status]!,
      'users': instance.users,
    };

const _$StatusEnumMap = {
  Status.initial: 'initial',
  Status.loading: 'loading',
  Status.error: 'error',
  Status.success: 'success',
};
