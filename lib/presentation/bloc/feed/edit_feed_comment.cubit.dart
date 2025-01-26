part of '../export.bloc.dart';

@injectable
class CreateFeedCommentCubit extends Cubit<EditFeedCommentState>
    with LoggerUtil {
  final FeedEntity _feed;
  final FeedUseCase _useCase;

  CreateFeedCommentCubit(
      {@factoryParam required FeedEntity feed, required FeedUseCase useCase})
      : _feed = feed,
        _useCase = useCase,
        super(EditFeedCommentState(content: feed.content));

  initState({Status? status, String? errorMessage}) {
    emit(state.copyWith(status: status, errorMessage: errorMessage));
  }

  updateContent(String content) => emit(state.copyWith(content: content));

  Future<CommentEntity?> submit() async {
    if (state.status == Status.loading || state.content.isEmpty) {
      return null;
    }
    try {
      emit(state.copyWith(status: Status.loading));
      return await _useCase
          .createComment(feedId: _feed.id, content: state.content)
          .then((res) => res.fold((l) {
                // on failure
                emit(state.copyWith(
                    status: Status.error, errorMessage: l.message));
                return null;
              }, (r) {
                // on success
                emit(state.copyWith(
                    status: Status.success, content: '', errorMessage: ''));
                return r.payload;
              }));
    } catch (error) {
      // on error
      logger.e(error);
      emit(state.copyWith(status: Status.error, errorMessage: 'submit fails'));
    }
    return null;
  }
}

@injectable
class ModifyFeedCommentCubit extends CreateFeedCommentCubit {
  final CommentEntity _comment;

  ModifyFeedCommentCubit(
      {@factoryParam required super.feed,
      @factoryParam required CommentEntity comment,
      required super.useCase})
      : _comment = comment;

  @override
  Future<CommentEntity?> submit() async {
    if (state.status == Status.loading || state.content.isEmpty) {
      return null;
    }
    try {
      emit(state.copyWith(status: Status.loading));
      return await _useCase
          .createComment(feedId: _feed.id, content: state.content)
          .then((res) => res.fold((l) {
                // on failure
                emit(state.copyWith(
                    status: Status.error, errorMessage: l.message));
                return null;
              }, (r) {
                // on success
                emit(state.copyWith(
                    status: Status.success, content: '', errorMessage: ''));
                return r.payload;
              }));
    } catch (error) {
      // on error
      logger.e(error);
      emit(state.copyWith(status: Status.error, errorMessage: 'submit fails'));
    }
    return null;
  }
}
