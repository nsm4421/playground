part of '../export.usecase.dart';

class CreateChatUseCase {
  final ChatRepository _repository;

  CreateChatUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call(
      {required String title, required List<String> hashtags}) async {
    return await _repository.create(title: title, hashtags: hashtags);
  }
}
