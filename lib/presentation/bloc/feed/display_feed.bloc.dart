part of '../export.bloc.dart';

@lazySingleton
class DisplayFeedBloc extends DisplayBloc<FeedEntity> with LoggerUtil {
  final FeedUseCase _useCase;

  DisplayFeedBloc(this._useCase);

  @override
  Future<void> onMount(
      MountEvent event, Emitter<DisplayState<FeedEntity>> emit) async {
    try {
      emit(state.copyWith(status: Status.loading, isMounted: false));
      await _useCase
          .fetchFeed(page: 1, pageSize: event.pageSize ?? 20)
          .then((res) => res.fold((l) {
                logger.e(l.description);
                emit(state.copyWith(status: Status.error, message: l.message));
              }, (r) {
                emit(state.from(r.payload).copyWith(
                    status: Status.success,
                    message: r.message,
                    isMounted: true));
              }));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  @override
  Future<void> onFetch(
      FetchEvent event, Emitter<DisplayState<FeedEntity>> emit) async {
    try {
      if (state.isEnd) return;
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .fetchFeed(
              page: state.pageSize + 1,
              pageSize: state.pageSize,
              lastId: state.lastId)
          .then((res) => res.fold((l) {
                logger.e(l.description);
                emit(state.copyWith(status: Status.error, message: l.message));
              }, (r) {
                emit(state.from(r.payload).copyWith(
                    status: Status.success,
                    data: [...state.data, ...r.payload.data],
                    message: r.message));
              }));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }
}
