part of '../export.usecase.dart';

class CreateGroupChatUseCase {
  final GroupChatRepository _repository;

  CreateGroupChatUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call(
      {required String title, required List<String> hashtags}) async {
    return await _repository.createChat(title: title, hashtags: hashtags);
  }
}
