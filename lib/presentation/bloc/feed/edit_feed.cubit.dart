part of '../export.bloc.dart';

@lazySingleton
class CreateFeedCubit extends SimpleCubit with LoggerUtil {
  final FeedUseCase _useCase;

  CreateFeedCubit(this._useCase) : super();

  Future<void> submit(
      {required String content,
      required List<String> hashtags,
      required List<File> files}) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .createFeed(
            content: content,
            hashtags: hashtags,
            files: files,
          )
          .then((res) => res.fold(
              (l) => emit(state.copyWith(
                  status: Status.error, errorMessage: l.message)),
              (r) => emit(
                  state.copyWith(status: Status.success, errorMessage: ''))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, errorMessage: 'submit fails'));
    }
  }
}

@injectable
class ModifyFeedCubit extends CreateFeedCubit {
  final int _id;

  int get id => _id;

  ModifyFeedCubit(@factoryParam this._id, {required FeedUseCase useCase})
      : super(useCase);

  @override
  Future<void> submit(
      {required String content,
      required List<String> hashtags,
      required List<File> files}) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .modifyFeed(
            id: _id,
            content: content,
            hashtags: hashtags,
            files: files,
          )
          .then((res) => res.fold(
              (l) => emit(state.copyWith(
                  status: Status.error, errorMessage: l.message)),
              (r) => emit(
                  state.copyWith(status: Status.success, errorMessage: ''))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, errorMessage: 'submit fails'));
    }
  }
}
