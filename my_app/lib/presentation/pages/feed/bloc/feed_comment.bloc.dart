import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/constant/enums/status.enum.dart';
import 'package:my_app/domain/model/feed/feed_comment.model.dart';
import 'package:my_app/domain/usecase/feed/feed.usecase.dart';
import 'package:my_app/domain/usecase/feed/get/get_feed_comment.usecase.dart';
import 'package:my_app/presentation/pages/feed/bloc/feed_comment.event.dart';
import 'package:my_app/presentation/pages/feed/bloc/feed_comment.state.dart';

import '../../../../core/utils/logging/custom_logger.dart';

@injectable
class FeedCommentBloc extends Bloc<FeedCommentEvent, FeedCommentState> {
  final FeedUseCase _feedUseCase;

  FeedCommentBloc(this._feedUseCase) : super(const FeedCommentState()) {
    on<FeedCommentInitializedEvent>(_onInitialized);
  }

  void _onInitialized(
      FeedCommentInitializedEvent event, Emitter<FeedCommentState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading, feedId: event.feedId));
      final response = await _feedUseCase.execute(
          useCase: GetFeedCommentUseCase(event.feedId));
      response.when(success: (List<FeedCommentModel> comments) {
        emit(state.copyWith(status: Status.success, comments: comments));
      }, failure: (err) {
        CustomLogger.logger.e(err);
        emit(state.copyWith(status: Status.error));
      });
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }
}
