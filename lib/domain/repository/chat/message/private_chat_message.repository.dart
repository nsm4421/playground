import 'package:hot_place/domain/repository/chat/message/chat_message.repository.dart';

import '../../../../data/entity/chat/private_chat/message/private_chat_message.entity.dart';

abstract interface class PrivateChatMessageRepository
    implements ChatMessageRepository<PrivateChatMessageEntity> {}
