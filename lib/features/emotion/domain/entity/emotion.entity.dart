import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/constant/emotion_type.dart';

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
}
