import 'package:hot_place/data/entity/chat/private_chat/room/private_chat.entity.dart';
import 'package:injectable/injectable.dart';

import '../../../repository/chat/room/private_chat.repository.dart';
import 'case/create_private_chat.usecase.dart';
import 'case/delete_chat.usecase.dart';
import 'case/get_chat_stream.usecase.dart';
import 'case/update_private_last_message.usecase.dart';

@lazySingleton
class PrivateChatUseCase {
  final PrivateChatRepository _repository;

  PrivateChatUseCase(this._repository);

  @injectable
  CreatePrivateChat get createChat => CreatePrivateChat(_repository);

  @injectable
  DeleteChatUseCase<PrivateChatRepository> get deleteChat =>
      DeleteChatUseCase<PrivateChatRepository>(_repository);

  @injectable
  GetChatStreamUseCase<PrivateChatRepository, PrivateChatEntity>
      get chatStream =>
          GetChatStreamUseCase<PrivateChatRepository, PrivateChatEntity>(
              _repository);

  @injectable
  UpdatePrivateLastMessageUseCase get updateLastMessage =>
      UpdatePrivateLastMessageUseCase(_repository);
}
