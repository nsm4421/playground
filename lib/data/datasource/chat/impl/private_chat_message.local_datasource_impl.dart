import 'package:logger/logger.dart';
import 'package:my_app/core/util/box_mixin.dart';
import 'package:my_app/domain/model/chat/message/local_private_chat_message.model.dart';

import '../../../../core/constant/database.constant.dart';
import '../../../../core/exception/custom_exception.dart';
import '../abstract/private_chat_message.datasource.dart';

part '../abstract/private_chat_message.local_datasource.dart';

class LocalPrivateChatMessageDataSourceImpl
    with BoxMixin<LocalPrivateChatMessageModel>
    implements LocalPrivateChatMessageDataSource {
  final Logger _logger;

  LocalPrivateChatMessageDataSourceImpl(this._logger) {
    boxName = BoxName.privateChat.name;
  }

  @override
  Future<List<LocalPrivateChatMessageModel>> fetchLastMessages() async {
    try {
      final box = await getBox();
      Map<String, LocalPrivateChatMessageModel> latestMessages = {};
      for (final item in box.values) {
        if (latestMessages.containsKey(item.chatId) &&
            (latestMessages[item.chatId]!
                .createdAt!
                .isBefore(item.createdAt!))) {
          latestMessages[item.chatId] = item;
        } else if (!latestMessages.containsKey(item.chatId)) {
          latestMessages[item.chatId] = item;
        }
      }
      final messages = latestMessages.values.toList();
      messages.sort((a, b) => (b.createdAt!).compareTo(a.createdAt!));
      return messages;
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<Iterable<LocalPrivateChatMessageModel>> fetchMessagesByUser(
      String opponentUid) async {
    try {
      return (await getBox()).values.where((item) =>
          (item.senderUid == opponentUid) || (item.receiverUid == opponentUid));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> deleteMessageById(String messageId) async {
    try {
      return await (await getBox()).delete(messageId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveChatMessage(LocalPrivateChatMessageModel model) async {
    try {
      // chat id
      String chatId = model.chatId;
      if (chatId.isEmpty) {
        final users = [model.senderUid, model.receiverUid];
        users.sort();
        chatId = users.join();
      }
      model.chatId = chatId;
      return await (await getBox()).put(model.id, model);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}
