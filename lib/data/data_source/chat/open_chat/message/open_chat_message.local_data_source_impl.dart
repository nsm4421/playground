import 'package:hive_flutter/hive_flutter.dart';
import 'package:hot_place/data/data_source/chat/open_chat/message/open_chat_message.data_source.dart';
import 'package:logger/logger.dart';

import '../../../../../core/constant/hive.constant.dart';
import '../../../../../core/error/custom_exception.dart';
import '../../../../../core/error/failure.constant.dart';
import '../../../../../domain/model/chat/open_chat/message/open_chat_message.local_model.dart';

class LocalOpenChatMessageDataSourceImpl
    implements LocalOpenChatMessageDataSource {
  bool _isInitialized = false;
  late Box<LocalOpenChatMessageModel> _$box;
  final _logger = Logger();

  Future<Box<LocalOpenChatMessageModel>> _getBox() async {
    if (!_isInitialized) {
      _$box = await Hive.openBox(BoxNames.openChatMessages.name);
    }
    _isInitialized = true;
    return _$box;
  }

  @override
  Future<void> saveChatMessages(
      Iterable<LocalOpenChatMessageModel> messages) async {
    try {
      final box = await _getBox();
      for (final message in messages) {
        await box.put(message.id, message);
      }
    } on HiveError catch (err) {
      _logger.e(err);
      throw CustomException(code: ErrorCode.hiveError, message: err.message);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.internalServerError, message: err.toString());
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
    } on HiveError catch (err) {
      _logger.e(err);
      throw CustomException(code: ErrorCode.hiveError, message: err.message);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.internalServerError, message: err.toString());
    }
  }
}
