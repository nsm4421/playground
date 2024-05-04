import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/constant/notification.constant.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/feed/base/feed.entity.dart';
import 'package:hot_place/data/entity/feed/like/like_feed.entity.dart';
import 'package:hot_place/data/entity/notification/notification.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/usecase/feed/feed.usecase.dart';
import 'package:hot_place/domain/usecase/notification/notification.usecase.dart';
import 'package:injectable/injectable.dart';

part 'feed.state.dart';

part 'feed.event.dart';

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedUseCase _feedUseCase;
  final NotificationUseCase _notificationUseCase;

  Stream<List<FeedEntity>> get feedStream => _feedUseCase.feedStream();

  Stream<Iterable<LikeFeedEntity>> get likeFeedStream =>
      _feedUseCase.likeStream();

  FeedBloc(
      {required FeedUseCase feedUseCase,
      required NotificationUseCase notificationUseCase})
      : _feedUseCase = feedUseCase,
        _notificationUseCase = notificationUseCase,
        super(InitialFeedState()) {
    on<InitFeedEvent>(_onInit);
    on<SearchFeedsByHashtagEvent>(_onSearchByHashtag);
    on<UploadingFeedEvent>(_onUpload);
    on<LikeFeedEvent>(_onLikeFeed);
    on<CancelLikeFeedEvent>(_onCancelLikeFeed);
  }

  // 피드 목록 초기화
  Future<void> _onInit(InitFeedEvent event, Emitter<FeedState> emit) async {
    emit(InitialFeedState());
  }

  // 피드 업로드
  Future<void> _onUpload(
      UploadingFeedEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState());
    // feed id
    final feedId = UuidUtil.uuid();
    List<String> images = [];

    // 이미지 업로드
    if (event.images.isNotEmpty) {
      final uploadImageResponse = await _feedUseCase.uploadFeedImages(
          feedId: feedId, images: event.images);
      uploadImageResponse
          .fold((l) => emit(FeedFailureState(l.message ?? 'error...')), (r) {
        images = r;
      });
      if (uploadImageResponse.isLeft()) {
        return;
      }
    }

    // 피드 업로드
    final createFeedResponse = await _feedUseCase.createFeed(
        currentUser: event.user,
        content: event.content,
        hashtags: event.hashtags,
        images: images);
    createFeedResponse.fold(
      (l) => emit(FeedFailureState(l.message ?? 'error...')),
      (r) => emit(UploadingFeedSuccessState()),
    );
  }

  /// Search
  Future<void> _onSearchByHashtag(
      SearchFeedsByHashtagEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState());
    final res = await _feedUseCase.getFeedsByHashtag(event.hashtag,
        page: event.page, size: event.size);
    res.fold((l) => emit(FeedFailureState(l.message ?? 'error...')),
        (r) => emit(SearchFeedSuccessState(hashtag: event.hashtag, feeds: r)));
  }

  /// Like
  Future<void> _onLikeFeed(LikeFeedEvent event, Emitter<FeedState> emit) async {
    // 좋아요
    try {
      await _feedUseCase.likeFeed(event._feed.id!);
    } catch (err) {
      debugPrint(err.toString());
    }
    // 알림
    try {
      if (event._currentUser.id != event._feed.user.id) {
        await _notificationUseCase.create(
          receiverId: event._feed.user.id!,
          createdBy: event._currentUser.id!,
          type: NotificationType.like,
          message: '${event._feed.user.nickname}님이 게시글에 좋아요를 눌렀습니다',
        );
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> _onCancelLikeFeed(
      CancelLikeFeedEvent event, Emitter<FeedState> emit) async {
    try {
      await _feedUseCase.cancelLike(event._feed.id!);
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
