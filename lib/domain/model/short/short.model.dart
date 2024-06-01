import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/short/short.entity.dart';

part 'short.model.freezed.dart';

part 'short.model.g.dart';

@freezed
class ShortModel with _$ShortModel {
  const factory ShortModel({
    @Default('') String id,
    @Default('') String title,
    @Default('') String content,
    @Default('') String shortUrl,
    String? createdAt,
    String? createdBy,
  }) = _ShortModel;

  factory ShortModel.fromJson(Map<String, dynamic> json) =>
      _$ShortModelFromJson(json);

  factory ShortModel.fromEntity(ShortEntity entity) => ShortModel(
        id: entity.id ?? '',
        title: entity.title ?? '',
        content: entity.content ?? '',
        shortUrl: entity.shortUrl ?? '',
        createdAt: entity.createdAt,
        createdBy: entity.createdBy,
      );
}
