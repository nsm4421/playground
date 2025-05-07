part of '../export.bloc.dart';

@injectable
class CreateGroupChatCubit extends SimpleCubit with LoggerUtil {
  final GroupChatUseCase _useCase;

  CreateGroupChatCubit(this._useCase):super();

  Future<void> submit(
      {required String title, required List<String> hashtags}) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.create(title: title, hashtags: hashtags).then((res) =>
          res.fold(
              (l) => emit(state.copyWith(
                  status: Status.error, errorMessage: l.message)),
              (r) => emit(
                  state.copyWith(status: Status.success, errorMessage: ''))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, errorMessage: 'fails'));
    }
  }
}
