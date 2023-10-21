// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchModelImpl _$$MatchModelImplFromJson(Map<String, dynamic> json) =>
    _$MatchModelImpl(
      matchId: json['matchId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      matchUserId: json['matchUserId'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      removedAt: json['removedAt'] == null
          ? null
          : DateTime.parse(json['removedAt'] as String),
    );

Map<String, dynamic> _$$MatchModelImplToJson(_$MatchModelImpl instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'userId': instance.userId,
      'matchUserId': instance.matchUserId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'removedAt': instance.removedAt?.toIso8601String(),
    };
