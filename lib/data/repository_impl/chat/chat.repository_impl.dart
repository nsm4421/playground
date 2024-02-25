import 'package:hot_place/data/data_source/chat/chat.data_source.dart';
import 'package:hot_place/data/data_source/user/credential.data_source.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/data/model/chat/message.model.dart';
import 'package:hot_place/domain/entity/chat/chat.entity.dart';
import 'package:hot_place/domain/entity/chat/message.entity.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

import '../../model/chat/chat.model.dart';

@Singleton(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final UserDataSource _userDataSource;
  final CredentialDataSource _credentialDataSource;
  final ChatDataSource _chatDataSource;

  ChatRepositoryImpl({
    required UserDataSource userDataSource,
    required CredentialDataSource credentialDataSource,
    required ChatDataSource chatDataSource,
  })  : _userDataSource = userDataSource,
        _credentialDataSource = credentialDataSource,
        _chatDataSource = chatDataSource;

  @override
  Future<Stream<List<ChatEntity>>> getChatStream() async {
    final currentUid = _credentialDataSource.currentUid;
    final currentUser =
        UserEntity.fromModel(await _userDataSource.findUserById(currentUid!));
    return _chatDataSource
        .getChatStream()
        .asyncMap((List<ChatModel> chatModels) async {
      List<ChatEntity> chatEntities = [];
      bool isHost = false;
      for (final model in chatModels) {
        isHost = currentUid == model.hostUid;
        final opponent = UserEntity.fromModel(await _userDataSource
            .findUserById(isHost ? model.guestUid : model.hostUid));
        final entity = ChatEntity.fromModel(
            model: model,
            host: isHost ? currentUser : opponent,
            guest: isHost ? opponent : currentUser);
        chatEntities.add(entity);
      }
      return chatEntities;
    });
  }

  @override
  Future<Stream<List<MessageEntity>>> getMessageStream(
      MessageEntity message) async {
    final chatEntity = await findChatById(message.chatId!);
    final currentUid = _credentialDataSource.currentUid;
    final currentUser =
        chatEntity.host?.uid == currentUid ? chatEntity.host : chatEntity.guest;
    final opponent =
        chatEntity.host?.uid == currentUid ? chatEntity.guest : chatEntity.host;
    return _chatDataSource
        .getMessageStream(message.chatId!)
        .asyncMap((List<MessageModel> messageModels) async {
      List<MessageEntity> messageEntities = [];
      for (final model in messageModels) {
        final entity = MessageEntity.fromModel(
            model: model,
            sender: model.senderUid == currentUid ? currentUser! : opponent!,
            receiver:
                model.receiverUid == currentUid ? currentUser! : opponent!);
        messageEntities.add(entity);
      }
      return messageEntities;
    });
  }

  @override
  Future<ChatEntity> findChatById(String chatId) async {
    final chatModel = await _chatDataSource.findChatById(chatId);
    return ChatEntity(
        id: chatModel.id,
        lastMessage: chatModel.lastMessage,
        unReadCount: chatModel.unReadCount,
        host: UserEntity.fromModel(
            await _userDataSource.findUserById(chatModel.hostUid)),
        guest: UserEntity.fromModel(
            await _userDataSource.findUserById(chatModel.guestUid)));
  }

  @override
  Future<void> sendMessage(MessageEntity message) async {
    final chatId = message.chatId ??
        // 채팅방 id가 주어지지 않은 경우, 채팅방을 새로 개설
        await _chatDataSource.createChat(ChatEntity(
                lastMessage: "채팅방이 개설되었습니다",
                guest: UserEntity(uid: message.receiver?.uid))
            .toModel());
    await _chatDataSource
        .createMessage(message.copyWith(chatId: chatId).toModel());
  }

  @override
  Future<void> deleteChat(ChatEntity chat) async =>
      await _chatDataSource.deleteChat(chat.toModel());

  @override
  Future<void> deleteMessage(MessageEntity message) async =>
      await _chatDataSource.deleteMessage(message.toModel());

  @override
  Future<void> seenMessageUpdate(MessageEntity message) async {
    await _chatDataSource.seenMessageUpdate(message.toModel());
  }
}
