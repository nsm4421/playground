import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/constant/enums/status.enum.dart';
import 'package:my_app/core/utils/logging/custom_logger.dart';
import 'package:my_app/data/data_source/remote/feed/feed.api.dart';
import 'package:my_app/dependency_injection.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';
import 'package:my_app/domain/usecase/feed/feed.usecase.dart';
import 'package:my_app/domain/usecase/feed/get/get_feed.usecase.dart';
import 'package:my_app/presentation/pages/home/bloc/feed.event.dart';
import 'package:my_app/presentation/pages/home/bloc/feed.state.dart';

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedUseCase _feedUseCase;

  FeedBloc(this._feedUseCase) : super(const FeedState()) {
    on<FeedInitializedEvent>(_onInitialized);
  }

  void _onInitialized(
      FeedInitializedEvent event, Emitter<FeedState> emit) async {
    try {
      final response = await _feedUseCase.execute(useCase: GetFeedUseCase());
      response.when(success: (List<FeedModel> feeds) {
        emit(state.copyWith(
            status: Status.initial,
            feedStream: getIt<FeedApi>().getFeedStream()));
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
