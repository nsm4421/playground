import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_diary.freezed.dart';

part 'edit_diary.g.dart';

@freezed
class EditDiaryModel with _$EditDiaryModel {
  const factory EditDiaryModel({
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
  }) = _EditDiaryModel;

  factory EditDiaryModel.fromJson(Map<String, dynamic> json) =>
      _$EditDiaryModelFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'updated_at': updated_at.isNotEmpty
          ? updated_at
          : DateTime.now().toUtc().toIso8601String(),
    };
  }
}
