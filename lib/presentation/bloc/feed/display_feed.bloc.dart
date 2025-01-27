part of '../export.bloc.dart';

@injectable
class DisplayFeedBloc extends DisplayBloc<FeedEntity> with LoggerUtil {
  final FeedUseCase _useCase;

  DisplayFeedBloc(this._useCase) {
    on<DeleteDisplayDataEvent<FeedEntity>>(_onDelete);
  }

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
                      isMounted: true,
                      data: r.payload.data,
                      totalCount: r.payload.totalCount,
                      currentPage: r.payload.currentPage,
                      totalPages: r.payload.totalPages,
                      isEnd: r.payload.currentPage >= r.payload.totalPages,
                      pageSize: r.payload.pageSize,
                    ));
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
          .fetchFeed(page: state.pageSize + 1, pageSize: state.pageSize)
          .then((res) => res.fold((l) {
                logger.e(l.description);
                emit(state.copyWith(status: Status.error, message: l.message));
              }, (r) {
                final data = r.payload.data.where((fetched) => !state.data
                    .map((item) => item.id)
                    .contains(fetched.id)); // 중복 제거
                emit(state.from(r.payload).copyWith(
                    status: Status.success,
                    data: [...state.data, ...data],
                    totalCount: r.payload.totalCount,
                    currentPage: r.payload.currentPage,
                    totalPages: r.payload.totalPages,
                    isEnd: r.payload.currentPage >= r.payload.totalPages,
                    pageSize: r.payload.pageSize,
                    message: r.message));
              }));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onDelete(DeleteDisplayDataEvent<FeedEntity> event,
      Emitter<DisplayState<FeedEntity>> emit) async {
    try {
      await _useCase.deleteFeed(event.e.id).then((res) => res.fold(
          (l) => emit(state.copyWith(status: Status.error, message: l.message)),
          (r) => emit(state.copyWith(
              status: Status.success,
              data: state.data
                  .where((item) => item.id != event.e.id)
                  .toList()))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }
}
