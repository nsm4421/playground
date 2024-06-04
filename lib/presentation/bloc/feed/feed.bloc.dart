import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/feed/feed.entity.dart';
import 'package:my_app/domain/usecase/module/feed/feed.usecase.dart';
import 'package:uuid/uuid.dart';

part "feed.state.dart";

part "feed.event.dart";

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedUseCase _useCase;

  late DateTime _afterAt;
  late Stream<List<FeedEntity>> _feedStream;

  FeedBloc({required FeedUseCase useCase})
      : _useCase = useCase,
        super(InitialFeedState()) {
    _afterAt = DateTime.now();
    _feedStream =
        _useCase.feedStream.call(afterAt: _afterAt.toIso8601String())!;
    on<InitFeedEvent>(_onInit);
    on<FetchFeedEvent>(_onFetch);
    on<UploadFeedEvent>(_onUpload);
  }

  DateTime get afterAt => _afterAt;

  Stream<List<FeedEntity>> get feedStream => _feedStream;

  Future<void> _onInit(InitFeedEvent event, Emitter<FeedState> emit) async {
    try {
      emit(InitialFeedState());
    } catch (error) {
      log(error.toString());
      emit(FeedFailureState('init feed fails'));
    }
  }

  Future<void> _onFetch(FetchFeedEvent event, Emitter<FeedState> emit) async {
    try {
      emit(FeedLoadingState());
      final res = await _useCase.fetchFeeds(
          afterAt: _afterAt.toIso8601String(), take: event._take);
      res.fold(
          (l) => emit(FeedFailureState(l.message ?? 'getting feeds fails')),
          (r) {
        emit(FetchFeedSuccessState(r));
        if (r.isNotEmpty) {
          _afterAt = r.map((e) => e.createdAt).filter((c) => c != null).reduce(
              (curr, next) =>
                  curr!.millisecondsSinceEpoch < next!.millisecondsSinceEpoch
                      ? curr
                      : next)!;
        }
      });
    } catch (error) {
      log(error.toString());
      emit(FeedFailureState('getting feeds fails'));
    }
  }

  Future<void> _onUpload(UploadFeedEvent event, Emitter<FeedState> emit) async {
    try {
      emit(FeedLoadingState());
      final feedId = const Uuid().v4();
      List<String> imageUrls = [];
      String? videoUrl;

      // set image urls
      if (event._images.isNotEmpty) {
        await _useCase
            .uploadImages(feedId: feedId, images: event._images)
            .then((res) => res.fold((l) =>throw l.toCustomException(), (r) {
                  imageUrls = r;
                }));
      }

      // set video url
      if (event._video != null) {
        await _useCase
            .uploadVideo(feedId: feedId, video: event._video)
            .then((res) => res.fold((l) =>throw l.toCustomException(), (r) {
                  videoUrl = r;
                }));
      }

      // save feed
      await _useCase.saveFeed(FeedEntity(
          id: (const Uuid()).v4(),
          text: event._text,
          hashtags: event._hashtags,
          imageUrls: imageUrls,
          videoUrl: videoUrl,
          createdAt: DateTime.now())).then((res)=>
      res.fold((l)=>throw l.toCustomException(), (r)=>UploadFeedSuccessState())
      );
    } catch (error) {
      log(error.toString());
      emit(FeedFailureState('getting short fails'));
    }
  }
}
