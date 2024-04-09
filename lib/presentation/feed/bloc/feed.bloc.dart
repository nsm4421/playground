import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/feed/feed.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/usecase/auth/get_current_user.usecase.dart';
import 'package:hot_place/domain/usecase/feed/create_feed.usecase.dart';
import 'package:hot_place/domain/usecase/feed/delete_feed_by_id.usecase.dart';
import 'package:hot_place/domain/usecase/feed/get_feeds.usecase.dart';
import 'package:hot_place/domain/usecase/feed/modify_feed.usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/feed/upload_feed_images.usecase.dart';

part 'feed.state.dart';

part 'feed.event.dart';

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedsUseCase _getFeedsUseCase;
  final GetCurrentUserUserCase _getCurrentUserUserCase;
  final CreateFeedUseCase _createFeedUseCase;
  final ModifyFeedUseCase _modifyFeedUseCase;
  final DeleteFeedByIdUseCase _deleteFeedByIdUseCase;
  final UploadFeedImagesUseCase _uploadFeedImagesUseCase;

  FeedBloc({
    required GetFeedsUseCase getFeedsUseCase,
    required GetCurrentUserUserCase getCurrentUserUserCase,
    required CreateFeedUseCase createFeedUseCase,
    required ModifyFeedUseCase modifyFeedUseCase,
    required DeleteFeedByIdUseCase deleteFeedByIdUseCase,
    required UploadFeedImagesUseCase uploadFeedImagesUseCase,
  })  : _getFeedsUseCase = getFeedsUseCase,
        _getCurrentUserUserCase = getCurrentUserUserCase,
        _createFeedUseCase = createFeedUseCase,
        _modifyFeedUseCase = modifyFeedUseCase,
        _deleteFeedByIdUseCase = deleteFeedByIdUseCase,
        _uploadFeedImagesUseCase = uploadFeedImagesUseCase,
        super(InitialFeedState()) {
    on<FeedEvent>((event, emit) => emit(FeedLoadingState()));
    on<FetchingFeedsEvent>(_onFetch);
    on<UploadingFeedEvent>(_onUpload);
  }

  void _onFetch(FetchingFeedsEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState());
    final res = await _getFeedsUseCase(page: event.page, size: event.size);
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
          await _uploadFeedImagesUseCase(feedId: feedId, images: event.images);
      uploadImageResponse
          .fold((l) => emit(FeedFailureState(l.message ?? 'error...')), (r) {
        images = r;
      });
      if (uploadImageResponse.isLeft()) {
        return;
      }
    }

    final createFeedResponse = await _createFeedUseCase(FeedEntity(
        id: feedId,
        user: event.user,
        content: event.content,
        hashtags: event.hashtags,
        images: images));
    createFeedResponse.fold(
      (l) => emit(FeedFailureState(l.message ?? 'error...')),
      (r) => emit(UploadingFeedSuccessState()),
    );
  }
}
