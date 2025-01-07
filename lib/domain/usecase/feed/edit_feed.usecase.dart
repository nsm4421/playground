part of '../export.usecase.dart';

class CreateFeedUseCase {
  final FeedRepository _repository;

  CreateFeedUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call(
      {required List<File> files,
      required String content,
      required List<String> hashtags}) async {
    return await _repository.create(
        files: files, content: content, hashtags: hashtags);
  }
}

class ModifyFeedUseCase {
  final FeedRepository _repository;

  ModifyFeedUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call(
      {required int id,
      required List<File> files,
      required String content,
      required List<String> hashtags}) async {
    return await _repository.modify(
        id: id, files: files, content: content, hashtags: hashtags);
  }
}
