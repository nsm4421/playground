import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

import '../../../../../core/constant/hive.constant.dart';
import '../../../../../core/util/exeption.util.dart';
import '../../../../../domain/model/chat/open_chat/message/open_chat_message.local_model.dart';
import 'local_data_source.dart';

class LocalOpenChatMessageDataSourceImpl
    implements LocalOpenChatMessageDataSource {
  bool _isInitialized = false;
  late Box<LocalOpenChatMessageModel> _$box;

  Future<Box<LocalOpenChatMessageModel>> _getBox() async {
    if (!_isInitialized) {
      _$box = await Hive.openBox(BoxNames.openChatMessages.name);
    }
    _isInitialized = true;
    return _$box;
  }

  final Logger _logger;

  LocalOpenChatMessageDataSourceImpl(this._logger);

  @override
  Future<void> saveChatMessages(
      Iterable<LocalOpenChatMessageModel> messages) async {
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
  Future<List<LocalOpenChatMessageModel>> getChatMessages(String chatId,
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
  Future<void> deleteChatMessageById(String messageId) async {
    try {
      final box = await _getBox();
      await box.delete(messageId);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
