import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'like.model.freezed.dart';

part 'like.model.g.dart';

@freezed
class LikeModel with _$LikeModel {
  const factory LikeModel({
    @Default('') String id,
    @Default('') String uid,
    @Default('') String postId,
    DateTime? createdAt,
  }) = _LikeModel;

  factory LikeModel.fromJson(Map<String, dynamic> json) =>
      _$LikeModelFromJson(json);
}
