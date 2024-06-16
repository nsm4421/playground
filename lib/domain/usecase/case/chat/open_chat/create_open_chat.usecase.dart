part of 'package:my_app/domain/usecase/module/chat/open_chat.usecase.dart';

class CreateOpenChatUseCase {
  final OpenChatRepository _repository;

  CreateOpenChatUseCase(this._repository);

  Future<Either<Failure, void>> call(OpenChatEntity entity) async {
    return await _repository.saveChat(entity);
  }
}
