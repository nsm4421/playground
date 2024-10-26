part of '../usecase.dart';

class FetchCommentUseCase {
  final BaseEntity _ref;
  final CommentRepository _repository;

  FetchCommentUseCase(this._repository, {required BaseEntity ref}) : _ref = ref;

  Future<Either<ErrorResponse, List<CommentEntity>>> call(
      {required String beforeAt, int take = 20}) async {
    return await _repository
        .fetch(ref: _ref, beforeAt: beforeAt, take: take)
        .then((res) => (res)
            .mapLeft((l) => l.copyWith(message: 'fail to fetch comments')));
  }
}

class CreateCommentUseCase {
  final CommentRepository _repository;
  final BaseEntity _ref;

  CreateCommentUseCase(this._repository, {required BaseEntity ref})
      : _ref = ref;

  Future<Either<ErrorResponse, void>> call(
      {required String content, required String refId}) async {
    return await _repository.create(ref: _ref, content: content).then((res) =>
        res.mapLeft((l) => l.copyWith(message: 'fail to create comment')));
  }
}

class ModifyCommentUseCase {
  final CommentRepository _repository;

  ModifyCommentUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String commentId, required String content}) async {
    return await _repository
        .modifyById(commentId: commentId, content: content)
        .then((res) =>
            res.mapLeft((l) => l.copyWith(message: 'fail to modify comment')));
  }
}

class DeleteCommentUseCase {
  final CommentRepository _repository;

  DeleteCommentUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String commentId) async {
    return await _repository.deleteById(commentId).then((res) =>
        res.mapLeft((l) => l.copyWith(message: 'fail to delete comment')));
  }
}
