part of '../export.bloc.dart';

@injectable
class CreateFeedCubit extends Cubit<EditFeedState> with LoggerUtil {
  final FeedUseCase _useCase;

  CreateFeedCubit(this._useCase) : super(EditFeedState());

  initState({Status? status, String? errorMessage}) {
    emit(state.copyWith(status: status, errorMessage: errorMessage));
  }

  updateContent(String content) => emit(state.copyWith(content: content));

  updateFiles(List<File> files) => emit(state.copyWith(files: files));

  updateHashtags(List<String> hashtags) =>
      emit(state.copyWith(hashtags: hashtags));

  Future<void> submit() async {
    if (!state.canSubmit) {
      return;
    }
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .createFeed(
            content: state.content,
            hashtags: state.hashtags,
            files: state.files,
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
  Future<void> submit() async {
    try {
      if (!state.canSubmit) {
        return;
      }
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .modifyFeed(
            id: _id,
            content: state.content,
            hashtags: state.hashtags,
            files: state.files,
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
