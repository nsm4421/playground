import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/feed/feed.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/usecase/feed/feed.usecase.dart';
import 'package:injectable/injectable.dart';

part 'feed.state.dart';

part 'feed.event.dart';

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedUseCase _useCase;

  FeedBloc(this._useCase) : super(InitialFeedState()) {
    on<FeedEvent>((event, emit) => emit(FeedLoadingState()));
    on<FetchingFeedsEvent>(_onFetch);
    on<UploadingFeedEvent>(_onUpload);
  }

  void _onFetch(FetchingFeedsEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState());
    final res = await _useCase.getFeeds(page: event.page, size: event.size);
    res.fold((l) => emit(FeedFailureState(l.message ?? 'error...')),
        (r) => emit(FetchingFeedSuccessState(r)));
  }

  void _onUpload(UploadingFeedEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState());
    // feed id
    final feedId = UuidUtil.uuid();
    List<String> images = [];

    // 이미지 업로드
    if (event.images.isNotEmpty) {
      final uploadImageResponse =
          await _useCase.uploadFeedImages(feedId: feedId, images: event.images);
      uploadImageResponse
          .fold((l) => emit(FeedFailureState(l.message ?? 'error...')), (r) {
        images = r;
      });
      if (uploadImageResponse.isLeft()) {
        return;
      }
    }

    // 피드 업로드
    final createFeedResponse = await _useCase.createFeed(
        currentUser: event.user,
        content: event.content,
        hashtags: event.hashtags,
        images: images);
    createFeedResponse.fold(
      (l) => emit(FeedFailureState(l.message ?? 'error...')),
      (r) => emit(UploadingFeedSuccessState()),
    );
  }
}
