import 'dart:io';

import '../../../../shared/shared.export.dart';

enum CreateStep {
  selectMedia,
  detail,
  uploading;
}

abstract class BaseState {
  final String id;
  final Status status;
  final CreateStep step;
  final File? media;
  final String errorMessage;

  BaseState({
    required this.id,
    required this.status,
    this.step = CreateStep.selectMedia,
    required this.media,
    this.errorMessage = '',
  });

  BaseState copyWith(
      {Status? status, CreateStep? step, File? media, String? errorMessage});
}
