part of '../../module/chat/chat.usecase.dart';

class DeleteChatUseCase {
  final ChatRepository _repository;

  DeleteChatUseCase(this._repository);

  Future<Either<Failure, void>> call(ChatEntity entity) async =>
      await _repository.deleteChat(entity);
}
