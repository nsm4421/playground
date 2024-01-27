import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/user/user.model.dart';

part 'story.model.freezed.dart';

@freezed
class StoryModel with _$StoryModel {
  const factory StoryModel({
    required UserModel? user,
    required String? content,
    required List<String> imageUrls,
    DateTime? createdAt,
  }) = _StoryModel;
}
