import 'package:hot_place/core/constant/response.constant.dart';
import 'package:hot_place/data/data_source/chat/chat.data_source.dart';
import 'package:hot_place/data/data_source/user/credential.data_source.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/data/model/chat/message.model.dart';
import 'package:hot_place/data/model/response/response.model.dart';
import 'package:hot_place/domain/entity/chat/chat.entity.dart';
import 'package:hot_place/domain/entity/chat/message.entity.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../model/chat/chat.model.dart';

@Singleton(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final UserDataSource _userDataSource;
  final CredentialDataSource _credentialDataSource;
  final ChatDataSource _chatDataSource;

  final _logger = Logger();

  ChatRepositoryImpl({
    required UserDataSource userDataSource,
    required CredentialDataSource credentialDataSource,
    required ChatDataSource chatDataSource,
  })  : _userDataSource = userDataSource,
        _credentialDataSource = credentialDataSource,
        _chatDataSource = chatDataSource;

  @override
  Future<ResponseModel<Stream<List<ChatEntity>>>> getChatStream() async {
    try {
      final currentUid = _credentialDataSource.currentUid;
      final currentUser =
          UserEntity.fromModel(await _userDataSource.findUserById(currentUid!));
      final stream = _chatDataSource
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
      return ResponseModel<Stream<List<ChatEntity>>>.success(
          responseType: ResponseType.ok, data: stream);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<Stream<List<ChatEntity>>>.error();
    }
  }

  @override
  Future<ResponseModel<Stream<List<MessageEntity>>>> getMessageStream(
      MessageEntity message) async {
    try {
      final chatEntity = (await findChatById(message.chatId!)).data;
      final currentUid = _credentialDataSource.currentUid;
      if (chatEntity?.host?.uid == null || chatEntity?.guest?.uid == null) {
        return ResponseModel<Stream<List<MessageEntity>>>.error(
            responseType: ResponseType.badRequest,
            message: 'host or guest of chat entity is null');
      }
      final currentUser = chatEntity?.host?.uid == currentUid
          ? chatEntity?.host
          : chatEntity?.guest;
      final opponent = chatEntity?.host?.uid == currentUid
          ? chatEntity?.guest
          : chatEntity?.host;
      final stream = _chatDataSource
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
      return ResponseModel<Stream<List<MessageEntity>>>.success(data: stream);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<Stream<List<MessageEntity>>>.error();
    }
  }

  @override
  Future<ResponseModel<ChatEntity>> findChatById(String chatId) async {
    try {
      final chatModel = await _chatDataSource.findChatById(chatId);
      final chat = ChatEntity(
          id: chatModel.id,
          lastMessage: chatModel.lastMessage,
          unReadCount: chatModel.unReadCount,
          host: UserEntity.fromModel(
              await _userDataSource.findUserById(chatModel.hostUid)),
          guest: UserEntity.fromModel(
              await _userDataSource.findUserById(chatModel.guestUid)));
      return ResponseModel.success(data: chat);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<ChatEntity>.error();
    }
  }

  @override
  Future<ResponseModel<void>> sendMessage(MessageEntity message) async {
    try {
      final chatId = message.chatId ??
          // 채팅방 id가 주어지지 않은 경우, 채팅방을 새로 개설 후 id 가져오기
          await _chatDataSource.createChat(ChatEntity(
                  lastMessage: "채팅방이 개설되었습니다",
                  guest: UserEntity(uid: message.receiver?.uid))
              .toModel());
      await _chatDataSource
          .createMessage(message.copyWith(chatId: chatId).toModel());
      return ResponseModel<void>.success(data: null);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.error();
    }
  }

  @override
  Future<ResponseModel<void>> deleteChat(ChatEntity chat) async {
    try {
      await _chatDataSource.deleteChat(chat.toModel());
      return ResponseModel<void>.success(data: null);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.error();
    }
  }

  @override
  Future<ResponseModel<void>> deleteMessage(MessageEntity message) async {
    try {
      await _chatDataSource.deleteMessage(message.toModel());
      return ResponseModel<void>.success(data: null);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.error();
    }
  }

  @override
  Future<ResponseModel<void>> seenMessageUpdate(MessageEntity message) async {
    try {
      await _chatDataSource.seenMessageUpdate(message.toModel());
      return ResponseModel<void>.success(data: null);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.error();
    }
  }
}
