import 'package:hot_place/data/entity/chat/private_chat/room/private_chat.entity.dart';
import 'package:hot_place/domain/repository/chat/room/chat.repository.dart';

abstract interface class PrivateChatRepository
    implements ChatRepository<PrivateChatEntity> {}
