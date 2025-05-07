import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/emotion_type.dart';
import '../../../data/model/emotion/emotion.model.dart';

part 'emotion.entity.freezed.dart';

@freezed
class EmotionEntity with _$EmotionEntity {
  const factory EmotionEntity(
      {String? id,
      String? createdBy,
      @Default(EmotionType.like) EmotionType type,
      String? referenceId,
      String? referenceTable,
      DateTime? createdAt}) = _EmotionEntity;

  factory EmotionEntity.fromModel(EmotionModel model) => EmotionEntity(
      id: model.id.isNotEmpty ? model.id : null,
      createdBy: model.created_by.isNotEmpty ? model.created_by : null,
      type: model.type,
      referenceId: model.reference_id.isNotEmpty ? model.reference_id : null,
      referenceTable:
          model.reference_table.isNotEmpty ? model.reference_table : null,
      createdAt: model.created_at);
}
