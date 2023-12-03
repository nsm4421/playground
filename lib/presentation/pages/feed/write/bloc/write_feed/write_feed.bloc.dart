import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/utils/logging/custom_logger.dart';
import 'package:my_app/domain/usecase/feed/feed.usecase.dart';
import 'package:my_app/domain/usecase/feed/write/write_feed.usecase.dart';
import 'package:my_app/presentation/pages/feed/write/bloc/write_feed/write_feed.event.dart';
import 'package:my_app/presentation/pages/feed/write/bloc/write_feed/write_feed.state.dart';

import '../../../../../../core/constant/enums/status.enum.dart';
import '../../../../../../domain/model/feed/feed.model.dart';

@injectable
class WriteFeedBloc extends Bloc<WriteFeedEvent, WriteFeedState> {
  final FeedUseCase _feedUseCase;

  WriteFeedBloc(this._feedUseCase) : super(const WriteFeedState()) {
    on<WriteFeedInitializedEvent>(_onInitialized);
    on<SubmitFeedEvent>(_onSubmitFeed);
  }

  /// 업로드 화면 초기화
  void _onInitialized(
      WriteFeedInitializedEvent event, Emitter<WriteFeedState> emit) {
    try {
      emit(state.copyWith(status: Status.initial));
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }

  /// 피드 업로드
  Future<void> _onSubmitFeed(
      SubmitFeedEvent event, Emitter<WriteFeedState> emit) async {
    try {
      emit(state.copyWith(
          status: Status.loading,
          content: event.content,
          images: event.images,
          hashtags: event.hashtags));
      final response = await _feedUseCase.execute(
          useCase: WriteFeedUseCase(
              content: state.content,
              images: state.images,
              hashtags: state.hashtags));
      response.when(success: (FeedModel feed) {
        emit(state.copyWith(status: Status.success));
      }, failure: (err) {
        emit(state.copyWith(status: Status.error, error: err));
      });
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }
}
