import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_diary.freezed.dart';

part 'fetch_diary.g.dart';

@freezed
class FetchDiaryModel with _$FetchDiaryModel {
  const factory FetchDiaryModel({
    @Default('') String id,
    String? location,
    @Default('') String content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    @Default(<String>[]) List<String> captions,
    @Default(true) bool is_private,
    @Default('') String created_at,
    @Default('') String updated_at,

    /// author
    @Default('') String created_by,
    @Default('') String username,
    @Default('') String avatar_url,
  }) = _FetchDiaryModel;

  factory FetchDiaryModel.fromJson(Map<String, dynamic> json) =>
      _$FetchDiaryModelFromJson(json);
}
