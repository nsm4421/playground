import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/dto/user/user.dto.dart';

part 'story.dto.freezed.dart';

part 'story.dto.g.dart';

@freezed
class StoryDto with _$StoryDto {
  const factory StoryDto({
    @Default(UserDto()) UserDto? user,
    @Default('') String? content,
    @Default(<String>[]) List<String> imageUrls,
  }) = _StoryDto;

  factory StoryDto.fromJson(Map<String, dynamic> json) =>
      _$StoryDtoFromJson(json);
}