import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/short/short.model.dart';

part 'short.entity.freezed.dart';

part 'short.entity.g.dart';

@freezed
class ShortEntity with _$ShortEntity {
  const factory ShortEntity({
    String? id,
    String? title,
    String? content,
    String? shortUrl,
    String? createdAt,
    String? createdBy,
  }) = _ShortEntity;

  factory ShortEntity.fromJson(Map<String, dynamic> json) =>
      _$ShortEntityFromJson(json);

  factory ShortEntity.fromModel(ShortModel model) => ShortEntity(
      id: model.id.isEmpty ? null : model.id,
      title: model.title.isEmpty ? null : model.title,
      content: model.content.isEmpty ? null : model.content,
      shortUrl: model.shortUrl.isEmpty ? null : model.shortUrl,
      createdAt: model.createdAt,
      createdBy: model.createdBy);
}
