import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/bloc/feed/upload/upload_feed.state.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constant/status.dart';
import '../../../../data/entity/feed/feed.entity.dart';
import '../../../../domain/usecase/module/feed/feed.usecase.dart';

class UploadFeedCubit extends Cubit<UploadFeedState> {
  final FeedUseCase _useCase;

  UploadFeedCubit(this._useCase) : super(const UploadFeedState());

  setContent(String content) => emit(state.copyWith(content: content));

  setHashtags(List<String> hashtags) =>
      emit(state.copyWith(hashtags: hashtags));

  Future<void> upload() async {
    try {
      emit(state.copyWith(status: Status.loading));
      final feedId = const Uuid().v4();
      String? media;

      // 이미지 및 동영상 업로드
      if (state.file == null) {
        throw ArgumentError('image or video is not given');
      }
      await _useCase
          .saveMedia(feedId: feedId, type: state.type, file: state.file!)
          .then((res) => res.fold((l) => throw l.toCustomException(), (r) {
                media = r;
              }));

      // 피드 저장하기
      await _useCase
          .saveFeed(FeedEntity(
              id: (const Uuid()).v4(),
              caption: state.caption,
              content: state.content,
              hashtags: state.hashtags,
              media: media,
              createdAt: DateTime.now()))
          .then((res) => res.fold((l) => throw l.toCustomException(),
              (r) => emit(state.copyWith(status: Status.success))));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, message: '포스팅 업로드 중 오류가 발생했습니다'));
    }
  }
}
