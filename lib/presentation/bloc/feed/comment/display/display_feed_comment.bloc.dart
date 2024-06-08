part of '../feed_comment.bloc.dart';

class DisplayFeedCommentBloc
    extends Bloc<DisplayFeedCommentEvent, DisplayFeedCommentState> {
  final FeedCommentUseCase _useCase;
  final String _feedId;
  DateTime _afterAt = DateTime.now();

  DisplayFeedCommentBloc(this._feedId, {required FeedCommentUseCase useCase})
      : _useCase = useCase,
        super(InitialDisplayFeedCommentState()) {
    on<InitDisplayFeedCommentEvent>(_onInit);
  }

  Stream<List<FeedCommentEntity>> get commentStream => _useCase.commentStream
      .call(afterAt: _afterAt.toIso8601String(), feedId: _feedId);

  Future<void> _onInit(InitDisplayFeedCommentEvent event,
      Emitter<DisplayFeedCommentState> emit) async {
    try {
      emit(InitialDisplayFeedCommentState());
    } catch (error) {
      log(error.toString());
      emit(DisplayFeedCommentFailureState('댓글 목록 초기화에 실패하였습니다'));
    }
  }
}
