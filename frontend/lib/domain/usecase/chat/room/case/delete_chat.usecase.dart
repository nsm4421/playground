import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../repository/chat/room/chat.repository.dart';

class DeleteChatUseCase<T extends ChatRepository> {
  final T _repository;

  DeleteChatUseCase(this._repository);

  Future<Either<Failure, void>> call(String chatId) async {
    return await _repository.deleteChatById(chatId);
  }
}
