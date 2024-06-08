import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/entity/feed/base/feed.entity.dart';
import '../../../../domain/usecase/module/feed/feed.usecase.dart';

part 'display_feed.event.dart';

part 'display_feed.state.dart';

class DisplayFeedBloc extends Bloc<DisplayFeedEvent, DisplayFeedState> {
  final FeedUseCase _useCase;
  DateTime _afterAt = DateTime.now();

  DisplayFeedBloc(this._useCase) : super(InitialDisplayFeedState()) {
    on<InitDisplayFeedEvent>(_onInit);
    on<FetchDisplayFeedEvent>(_onFetch);
  }

  Stream<List<FeedEntity>> get feedStream =>
      _useCase.feedStream.call(afterAt: _afterAt.toIso8601String());

  Future<void> _onInit(
      InitDisplayFeedEvent event, Emitter<DisplayFeedState> emit) async {
    try {
      emit(InitialDisplayFeedState());
    } catch (error) {
      log(error.toString());
      emit(DisplayFeedFailureState('피드 목록 초기화에 실패하였습니다'));
    }
  }

  Future<void> _onFetch(
      FetchDisplayFeedEvent event, Emitter<DisplayFeedState> emit) async {
    try {
      emit(DisplayFeedLoadingState());
      final res = await _useCase.fetchFeeds(
          afterAt: _afterAt.toIso8601String(), take: event._take);
      res.fold((l) => throw l.toCustomException(), (r) {
        emit(DisplayFeedSuccessState(r));
        if (r.isNotEmpty) {
          _afterAt = r.map((e) => e.createdAt).reduce((curr, next) =>
              curr!.millisecondsSinceEpoch < next!.millisecondsSinceEpoch
                  ? curr
                  : next)!;
        }
      });
    } catch (error) {
      log(error.toString());
      emit(DisplayFeedFailureState('피드 목록 가져오기 실패하였습니다'));
    }
  }
}
