import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/status.dart';

part 'upload_short.state.freezed.dart';

@freezed
class UploadShortState with _$UploadShortState {
  const factory UploadShortState({
    @Default(Status.initial) Status status,
    File? video,
    @Default('') String title,
    @Default('') String content,
    @Default('') String errorMessage,
  }) = _UploadShortState;
}
