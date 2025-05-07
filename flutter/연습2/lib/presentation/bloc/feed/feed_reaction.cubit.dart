part of '../export.bloc.dart';

@injectable
class FeedReactionCubit extends ReactionCubit<FeedEntity> with LoggerUtil {
  final FeedEntity _feed;
  final FeedUseCase _useCase;

  FeedReactionCubit(@factoryParam this._feed, {required FeedUseCase useCase})
      : _useCase = useCase,
        super(ReactionState(reaction: _feed.reaction, ref: _feed));

  @override
  void initialize({Status? status, String? errorMessage}) {
    emit(state.copyWith(status: status, errorMessage: errorMessage));
  }

  @override
  Future<void> like() async {
    try {
      if (state.like) return;
      emit(state.copyWith(status: Status.loading));
      await _useCase.like.call(this._feed.id).then((res) => res.fold(
          (l) => emit(state.copyWith(errorMessage: l.message)),
          (r) => emit(state
              .copyWith(status: Status.success)
              .copyWithReaction(r.payload))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, errorMessage: 'like request fails'));
    }
  }

  @override
  Future<void> cancelLike() async {
    try {
      if (!state.like) return;
      emit(state.copyWith(status: Status.loading));
      await _useCase.cancelLike.call(this._feed.id).then((res) => res.fold(
          (l) => emit(state.copyWith(errorMessage: l.message)),
          (r) {
            emit(
                state.copyWith(status: Status.success).copyWithReaction(null));
          }));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, errorMessage: 'cancel like request fails'));
    }
  }
}
