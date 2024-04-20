import 'package:hive/hive.dart';
import 'package:hot_place/domain/model/chat/private_chat/message/private_chat_message.local_model.dart';
import 'package:logger/logger.dart';

import '../../../../../core/constant/hive.constant.dart';
import '../../../../../core/util/exeption.util.dart';
import 'local_data_source.dart';

class LocalPrivateChatMessageDataSourceImpl
    implements LocalPrivateChatMessageDataSource {
  bool _isInitialized = false;
  late Box<LocalPrivateChatMessageModel> _$box;

  Future<Box<LocalPrivateChatMessageModel>> _getBox() async {
    if (!_isInitialized) {
      _$box = await Hive.openBox(BoxNames.privateChatMessage.name);
    }
    _isInitialized = true;
    return _$box;
  }

  final Logger _logger;

  LocalPrivateChatMessageDataSourceImpl(this._logger);

  @override
  Future<List<LocalPrivateChatMessageModel>> getChatMessages(String chatId,
      {int? take}) async {
    try {
      final box = await _getBox();
      final messages = box.values
          .where((element) => element.chat_id == chatId)
          .where((element) => element.created_at != null)
          .toList();
      messages.sort(
          (before, after) => before.created_at!.compareTo(after.created_at!));
      return take != null ? messages.take(take).toList() : messages;
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> saveChatMessages(
      Iterable<LocalPrivateChatMessageModel> messages) async {
    try {
      final box = await _getBox();
      for (final message in messages) {
        await box.put(message.id, message);
      }
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> deleteChatMessageById(String messageId) async {
    try {
      final box = await _getBox();
      await box.delete(messageId);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
