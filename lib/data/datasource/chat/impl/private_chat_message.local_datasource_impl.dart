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
      return await (await getBox()).put(model.id, model);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}
