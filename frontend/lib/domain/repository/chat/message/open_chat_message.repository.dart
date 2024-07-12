import 'package:hot_place/data/entity/chat/open_chat/message/open_chat_message.entity.dart';
import 'package:hot_place/domain/repository/chat/message/chat_message.repository.dart';

abstract interface class OpenChatMessageRepository
    implements ChatMessageRepository<OpenChatMessageEntity> {}
