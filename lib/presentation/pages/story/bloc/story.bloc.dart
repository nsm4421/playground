import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/utils/logging/custom_logger.dart';
import 'package:my_app/domain/model/story/story.model.dart';
import 'package:my_app/domain/usecase/story/get_story.usecase.dart';
import 'package:my_app/presentation/pages/story/bloc/story.event.dart';
import 'package:my_app/presentation/pages/story/bloc/story.state.dart';

import '../../../../core/constant/enums/status.enum.dart';
import '../../../../core/utils/exception/custom_exception.dart';
import '../../../../domain/model/result/result.dart';
import '../../../../domain/usecase/story/story.usecase.dart';

@injectable
class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final StoryUseCase _storyUseCase;

  StoryBloc(this._storyUseCase) : super(const StoryState()) {
    on<StoryInitialized>(_onStoryInitialized);
  }

  Future<Result<List<StoryModel>>> _getStories() async =>
      await _storyUseCase.execute(useCase: GetStoryUseCase());

  Future<void> _onStoryInitialized(
      StoryInitialized event, Emitter<StoryState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final response = await _getStories();
      response.when(success: (stories) {
        emit(state.copyWith(status: Status.success, stories: stories));
      }, failure: (err) {
        emit(state.copyWith(status: Status.error, error: err));
      });
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(
          status: Status.error, error: CommonException.setError(err)));
    }
  }
}
