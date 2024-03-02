import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.model.freezed.dart';

part 'post.model.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    @Default('') String id,
    @Default('') String content,
    @Default('') String authorUid,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    DateTime? createdAt,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
