import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match.model.freezed.dart';

part 'match.model.g.dart';

@freezed
class MatchModel with _$MatchModel {
  const factory MatchModel({
    @Default('') String? matchId,
    @Default('') String? userId,
    @Default('') String? matchUserId,
    DateTime? createdAt,
    DateTime? removedAt,
  }) = _MatchModel;

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);
}
