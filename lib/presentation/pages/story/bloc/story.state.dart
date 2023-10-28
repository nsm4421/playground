import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/utils/exception/error_response.dart';

import '../../../../core/constant/enums/status.enum.dart';
import '../../../../domain/model/story/story.model.dart';

part 'story.state.freezed.dart';

@freezed
class StoryState with _$StoryState {
  const factory StoryState({
    @Default(Status.initial) Status status,
    @Default(<StoryModel>[]) List<StoryModel> stories,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _StoryState;
}
