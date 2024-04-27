import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/feed/base/feed.entity.dart';
import 'package:hot_place/data/entity/feed/like/like_feed.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/usecase/feed/feed.usecase.dart';
import 'package:injectable/injectable.dart';

part 'feed.state.dart';

part 'feed.event.dart';

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedUseCase _useCase;

  Stream<List<FeedEntity>> get feedStream => _useCase.feedStream();

  Stream<Iterable<LikeFeedEntity>> get likeFeedStream => _useCase.likeStream();

  FeedBloc(this._useCase) : super(InitialFeedState()) {
    on<FeedEvent>((event, emit) => emit(FeedLoadingState()));
    on<FetchingFeedsEvent>(_onFetch);
    on<UploadingFeedEvent>(_onUpload);
    on<LikeFeedEvent>(_onLikeFeed);
    on<CancelLikeFeedEvent>(_onCancelLikeFeed);
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

  void _onLikeFeed(LikeFeedEvent event, Emitter<FeedState> emit) async {
    _useCase.likeFeed(event.feedId);
  }

  void _onCancelLikeFeed(
      CancelLikeFeedEvent event, Emitter<FeedState> emit) async {
    _useCase.cancelLike(event.feedId);
  }
}
