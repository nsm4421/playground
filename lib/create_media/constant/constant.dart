import 'dart:io';

import '../../shared/shared.export.dart';

enum CreateMediaMode {
  feed('피드'),
  reels('릴스');

  final String label;

  const CreateMediaMode(this.label);
}

enum CreateMediaStep {
  selectMedia,
  detail,
  uploading,
  done;
}

abstract class BaseState {
  final String id;
  final Status status;
  final CreateMediaStep step;
  final File? media;
  final String errorMessage;

  BaseState({
    required this.id,
    required this.status,
    this.step = CreateMediaStep.selectMedia,
    required this.media,
    this.errorMessage = '',
  });

  BaseState copyWith({
    String? id,
    Status? status,
    CreateMediaStep? step,
    File? media,
    String? errorMessage,
  });
}
