part of '../export.bloc.dart';

@injectable
class DisplayGroupChatBloc extends DisplayBloc<GroupChatEntity>
    with LoggerUtil {
  final ChatUseCase _useCase;

  DisplayGroupChatBloc(this._useCase) {
    on<DeleteDisplayDataEvent<GroupChatEntity>>(_onDelete);
  }

  @override
  Future<void> onMount(
      MountEvent event, Emitter<DisplayState<GroupChatEntity>> emit) async {
    try {
      emit(state.copyWith(status: Status.loading, isMounted: false));
      await _useCase
          .fetchChats(page: 1, pageSize: event.pageSize ?? 20)
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
      FetchEvent event, Emitter<DisplayState<GroupChatEntity>> emit) async {
    try {
      if (state.isEnd) return;
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .fetchChats(page: state.currentPage + 1, pageSize: state.pageSize)
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
                    isEnd: r.payload.currentPage == r.payload.totalPages,
                    pageSize: r.payload.pageSize,
                    message: r.message));
              }));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onDelete(DeleteDisplayDataEvent<GroupChatEntity> event,
      Emitter<DisplayState<GroupChatEntity>> emit) async {
    try {
      await _useCase.delete.call(event.e.id).then((res) => res.fold(
          (l) => emit(state.copyWith(status: Status.error, message: l.message)),
          (r) => emit(state.copyWith(
              status: Status.success,
              message: r.message,
              data: state.data
                  .where((item) => item.id != event.e.id)
                  .toList()))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }
}
