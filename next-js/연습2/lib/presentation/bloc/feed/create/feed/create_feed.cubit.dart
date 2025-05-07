import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/domain/entity/auth/presence.entity.dart';
import 'package:portfolio/domain/usecase/auth/auth.usecase_module.dart';
import 'package:portfolio/domain/usecase/feed/feed.usecase_module.dart';
import 'package:portfolio/presentation/bloc/feed/create/feed/create_feed.state.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/constant/status.dart';

class CreateFeedCubit extends Cubit<CreateFeedState> {
  CreateFeedCubit(
      {required AuthUseCase authUseCase, required FeedUseCase feedUseCase})
      : _authUseCase = authUseCase,
        _feedUseCase = feedUseCase,
        super(const CreateFeedState());

  final AuthUseCase _authUseCase;
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
      final feedId = const Uuid().v4();
      final res = await _feedUseCase.createFeed(
          feedId: feedId, content: content, hashtags: hashtags, files: files);
      if (res.ok && res.data != null) {
        emit(state.copyWith(
            status: Status.success,
            saved: res.data!.copyWith(
                createdBy:
                    PresenceEntity.fromUser(_authUseCase.currentUser()!))));
      } else {
        emit(state.copyWith(status: Status.error, message: res.message ?? ""));
      }
    } catch (error) {
      log('[create feed cubit]', error: error);
      emit(state.copyWith(status: Status.error, message: 'create feed fails'));
    }
  }
}
