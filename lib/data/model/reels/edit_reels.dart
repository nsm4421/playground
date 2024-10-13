import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/util/util.dart';

part 'edit_reels.freezed.dart';

part 'edit_reels.g.dart';

@freezed
class EditReelsModel with _$EditReelsModel {
  const factory EditReelsModel({
    @Default('') String id,
    @Default('') String video,
    @Default('') String title,
    @Default('') String caption,
    String? location,
    @Default(true) bool is_private,
    @Default('') String created_at,
    @Default('') String updated_at,
    @Default('') String created_by,
  }) = _EditReelsModel;

  factory EditReelsModel.fromJson(Map<String, dynamic> json) =>
      _$EditReelsModelFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'updated_at': updated_at.isNotEmpty ? updated_at : customUtil.now
    };
  }
}
