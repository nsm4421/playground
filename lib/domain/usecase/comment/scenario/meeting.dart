part of '../usecase.dart';

class FetchMeetingCommentUseCase {
  final CommentRepository _repository;

  FetchMeetingCommentUseCase(this._repository);

  Future<Either<ErrorResponse, List<CommentEntity>>> call(
      {required String meetingId,
      required String beforeAt,
      int take = 20}) async {
    return await _repository.fetch(
        refTable: Tables.meeting,
        refId: meetingId,
        beforeAt: beforeAt,
        take: take);
  }
}

class CreateMeetingCommentUseCase {
  final CommentRepository _repository;

  CreateMeetingCommentUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String content, required String meetingId}) async {
    return await _repository
        .create(refTable: Tables.meeting, refId: meetingId, content: content)
        .then((res) =>
            res.mapLeft((l) => l.copyWith(message: 'fail to create comment')));
  }
}

class ModifyMeetingCommentUseCase {
  final CommentRepository _repository;

  ModifyMeetingCommentUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String commentId, required String content}) async {
    return await _repository
        .modifyById(commentId: commentId, content: content)
        .then((res) =>
            res.mapLeft((l) => l.copyWith(message: 'fail to modify comment')));
  }
}

class DeleteMeetingCommentUseCase {
  final CommentRepository _repository;

  DeleteMeetingCommentUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String commentId) async {
    return await _repository.deleteById(commentId).then((res) =>
        res.mapLeft((l) => l.copyWith(message: 'fail to delete comment')));
  }
}
