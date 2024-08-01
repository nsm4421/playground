import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/emotion/core/constant/emotion_type.dart';

import '../../domain/entity/emotion.entity.dart';

part 'emotion.model.freezed.dart';

part 'emotion.model.g.dart';

@freezed
class EmotionModel with _$EmotionModel {
  const factory EmotionModel(
      {@Default('') String id,
      @Default('') String created_by,
      @Default(EmotionType.like) EmotionType type,
      @Default('') String reference_id,
      @Default('') String reference_table,
      DateTime? created_at}) = _EmotionModel;

  factory EmotionModel.fromJson(Map<String, dynamic> json) =>
      _$EmotionModelFromJson(json);

  factory EmotionModel.fromEntity(EmotionEntity entity) => EmotionModel(
      id: entity.id ?? "",
      created_by: entity.createdBy ?? "",
      type: entity.type,
      reference_id: entity.referenceId ?? "",
      reference_table: entity.referenceTable ?? "",
      created_at: entity.createdAt);
}
