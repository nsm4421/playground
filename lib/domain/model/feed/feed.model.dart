import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.model.freezed.dart';
part 'feed.model.g.dart';

@freezed
class FeedModel with _$FeedModel {
  const factory FeedModel({
    String? feedId,
    String? content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    String? uid,
    DateTime? createdAt,
  }) = _FeedModel;



  factory FeedModel.fromJson(Map<String, dynamic> json) =>
      _$FeedModelFromJson(json);
}