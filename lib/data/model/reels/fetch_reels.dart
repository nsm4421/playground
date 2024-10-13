import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_reels.freezed.dart';

part 'fetch_reels.g.dart';

@freezed
class FetchReelsModel with _$FetchReelsModel {
  const factory FetchReelsModel({
    @Default('') String id,
    @Default('') String video,
    @Default('') String title,
    @Default('') String caption,
    String? location,
    @Default(true) bool is_private,
    @Default('') String created_at,
    @Default('') String updated_at,

    /// author
    @Default('') String created_by,
    @Default('') String username,
    @Default('') String avatar_url,
  }) = _FetchReelsModel;

  factory FetchReelsModel.fromJson(Map<String, dynamic> json) =>
      _$FetchReelsModelFromJson(json);
}
