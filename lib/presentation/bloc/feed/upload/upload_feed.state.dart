import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/constant/media.dart';

import '../../../../core/constant/status.dart';

part 'upload_feed.state.freezed.dart';

@freezed
class UploadFeedState with _$UploadFeedState {
  const factory UploadFeedState({
    @Default(Status.initial) Status status,
    @Default('') String content,
    @Default('') String caption,
    @Default(<String>[]) List<String> hashtags,
    @Default(MediaType.image) MediaType type,
    File? file,
    @Default('') String message,
  }) = _UploadFeedState;
}
