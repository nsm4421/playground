import 'package:injectable/injectable.dart';
import 'package:my_app/domain/repository/chat.repository.dart';
import 'package:my_app/domain/usecase/base/remote.usecase.dart';

@singleton
class ChatUseCase {
  final ChatRepository _chatRepository;

  ChatUseCase(this._chatRepository);

  Future execute<T>({required RemoteUseCase useCase}) async =>
      await useCase(_chatRepository);
}
