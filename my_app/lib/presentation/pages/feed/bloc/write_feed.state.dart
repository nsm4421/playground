import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../../../../core/constant/enums/status.enum.dart';
import '../../../../core/utils/exception/error_response.dart';

part 'write_feed.state.freezed.dart';

@freezed
class WriteFeedState with _$WriteFeedState {
  const factory WriteFeedState({
    @Default(Status.initial) Status status,
    @Default('') String content,
    @Default(<Asset>[]) List<Asset> images,
    @Default(<String>[]) List<String> hashtags,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _WriteFeedState;
}
