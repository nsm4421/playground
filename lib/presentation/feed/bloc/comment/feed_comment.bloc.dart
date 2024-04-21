import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/usecase/feed/comment.usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/entity/feed/comment/feed_comment.entity.dart';
import '../../../../data/entity/user/user.entity.dart';

part 'feed_comment.state.dart';

part 'feed_comment.event.dart';

@injectable
class FeedCommentBloc extends Bloc<FeedCommentEvent, FeedCommentState> {
  late Stream<List<FeedCommentEntity>> _commentStream;
  late String _feedId;

  Stream<List<FeedCommentEntity>> get commentStream => _commentStream;

  final FeedCommentUseCase _useCase;

  FeedCommentBloc({required FeedCommentUseCase useCase})
      : _useCase = useCase,
        super(InitialFeedCommentState()) {
    on<InitFeedCommentStateEvent>(_onInit);
    on<CreateFeedCommentEvent>(_onCreate);
    on<ModifyFeedCommentEvent>(_onModify);
    on<DeleteFeedCommentEvent>(_onDelete);
  }

  void _onInit(
      InitFeedCommentStateEvent event, Emitter<FeedCommentState> emit) async {
    emit(FeedCommentLoadingState());
    _feedId = event.feedId;
    // 댓글 스트림 초기화
    _useCase.commentStream.call(_feedId).fold(
        (l) =>
            emit(FeedCommentFailureState(l.message ?? '댓글목록을 가져오는데 실패하였습니다')),
        (r) {
      _commentStream = r;
      emit(FeedCommentSuccessState());
    });
  }

  void _onCreate(
      CreateFeedCommentEvent event, Emitter<FeedCommentState> emit) async {
    emit(FeedCommentLoadingState());
    final res = await _useCase.createComment(
        feedId: _feedId,
        currentUser: event.currentUser,
        content: event.content);
    res.fold(
        (l) => emit(FeedCommentFailureState(l.message ?? '댓글 작성 요청이 실패하였습니다')),
        (r) {
      emit(FeedCommentSuccessState());
    });
  }

  void _onModify(
      ModifyFeedCommentEvent event, Emitter<FeedCommentState> emit) async {
    emit(FeedCommentLoadingState());
    final res = await _useCase.modifyComment(
        commentId: event.commentId,
        feedId: _feedId,
        currentUser: event.currentUser,
        content: event.content);
    res.fold(
        (l) => emit(FeedCommentFailureState(l.message ?? '댓글 작성 요청이 실패하였습니다')),
        (r) {
      emit(FeedCommentSuccessState());
    });
  }

  void _onDelete(
      DeleteFeedCommentEvent event, Emitter<FeedCommentState> emit) async {
    emit(FeedCommentLoadingState());
    final res = await _useCase.deleteComment(event.commentId);
    res.fold(
        (l) => emit(FeedCommentFailureState(l.message ?? '댓글 삭제 요청이 실패하였습니다')),
        (r) {
      emit(FeedCommentSuccessState());
    });
  }
}
