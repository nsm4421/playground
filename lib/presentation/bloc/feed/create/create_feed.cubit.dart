import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/domain/usecase/feed/feed.usecase_module.dart';
import 'package:portfolio/presentation/bloc/feed/create/create_feed.state.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constant/status.dart';

class CreateFeedCubit extends Cubit<CreateFeedState> {
  CreateFeedCubit(this._feedUseCase) : super(const CreateFeedState());

  final FeedUseCase _feedUseCase;

  init() {
    emit(state.copyWith(status: Status.initial));
  }

  submit(
      {required String content,
      required List<String> hashtags,
      required List<File> files}) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res = await _feedUseCase.createFeed(
          feedId: const Uuid().v4(),
          content: content,
          hashtags: hashtags,
          files: files);
      emit(state.copyWith(
          status: res.ok ? Status.success : Status.error,
          message: res.message ?? ""));
    } catch (error) {
      log('[create feed cubit]', error: error);
      emit(state.copyWith(status: Status.error, message: 'create feed fails'));
    }
  }
}
