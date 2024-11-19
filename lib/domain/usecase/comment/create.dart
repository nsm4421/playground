part of 'usecase.dart';

class CreateFeedCommentUseCase {
  final CommentRepository _repository;

  CreateFeedCommentUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String id,
      required String feedId,
      required String content}) async {
    return await _repository.create(
        id: id,
        referenceId: feedId,
        referenceTable: Tables.feeds.name,
        content: content);
  }
}

class CreateReelsCommentUseCase {
  final CommentRepository _repository;

  CreateReelsCommentUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String id,
      required String reelsId,
      required String content}) async {
    return await _repository.create(
        id: id,
        referenceId: reelsId,
        referenceTable: Tables.reels.name,
        content: content);
  }
}
