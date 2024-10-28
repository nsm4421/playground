import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/util/util.dart';

part 'edit_feed.freezed.dart';

part 'edit_feed.g.dart';

@freezed
class EditFeedModel with _$EditFeedModel {
  const factory EditFeedModel({
    @Default('') String id,
    @Default('') String content,
    String? location,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    @Default(<String>[]) List<String> captions,
    @Default(true) bool is_private,
    @Default('') String created_at,
    @Default('') String updated_at,
    @Default('') String created_by,
  }) = _EditFeedModel;

  factory EditFeedModel.fromJson(Map<String, dynamic> json) =>
      _$EditFeedModelFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'updated_at': updated_at.isNotEmpty ? updated_at : customUtil.now
    };
  }
}
