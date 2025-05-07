part of '../export.usecase.dart';

class FetchGroupChatUseCase {
  final GroupChatRepository _repository;

  FetchGroupChatUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<Pageable<GroupChatEntity>>>>
      call({required int page, int pageSize = 20}) async {
    return await _repository.fetchChats(page: page, pageSize: pageSize);
  }
}
