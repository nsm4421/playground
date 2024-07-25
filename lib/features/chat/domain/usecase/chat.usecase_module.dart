import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../main/core/constant/response_wrapper.dart';
import '../../data/repository_impl/open_chat.repository_impl.dart';
import '../entity/open_chat.entity.dart';

part "get_chat_stream.usecase.dart";

part "create_chat.usecase.dart";

@lazySingleton
class ChatUseCase {
  final OpenChatRepository _openChatRepository;

  ChatUseCase({required OpenChatRepository openChatRepository})
      : _openChatRepository = openChatRepository;

  @injectable
  GetOpenChatStreamUseCase get getOpenChatStream =>
      GetOpenChatStreamUseCase(_openChatRepository);

  @injectable
  CreateOpenChatUseCase get createOpenChat =>
      CreateOpenChatUseCase(_openChatRepository);
}
