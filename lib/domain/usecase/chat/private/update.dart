part of 'usecase.dart';

class UpdateLastSeenUseCase with CustomLogger {
  final PrivateChatRepository _repository;

  UpdateLastSeenUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String chatId, required DateTime lastSeen}) async {
    return await _repository.update(
        chatId: chatId, lastSeen: lastSeen.toUtc().toIso8601String());
  }
}
