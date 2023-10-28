import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/user/user.model.dart';

part 'story.model.freezed.dart';

part 'story.model.g.dart';

@freezed
class StoryModel with _$StoryModel {
  const factory StoryModel({
    required UserModel? user,
    required String? content,
    required String? imageUrl,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}
