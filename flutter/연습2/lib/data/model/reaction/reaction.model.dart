import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction.model.freezed.dart';

part 'reaction.model.g.dart';

@freezed
class ReactionDto with _$ReactionDto {
  const factory ReactionDto({
    @Default(0) int id,
    @Default('') String createdAt,
  }) = _ReactionDto;

  factory ReactionDto.fromJson(Map<String, dynamic> json) =>
      _$ReactionDtoFromJson(json);
}
