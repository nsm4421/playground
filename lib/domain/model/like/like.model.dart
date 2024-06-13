import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/constant/dto.constant.dart';

part 'like.model.freezed.dart';

part 'like.model.g.dart';

@freezed
class LikeModel with _$LikeModel {
  const factory LikeModel({
    @Default('') String id,
    @Default(LikeType.feed) LikeType type,
    @Default('') String referenceId,
    String? createdBy,
    String? createdAt,
  }) = _LikeModel;

  factory LikeModel.fromJson(Map<String, dynamic> json) =>
      _$LikeModelFromJson(json);
}
