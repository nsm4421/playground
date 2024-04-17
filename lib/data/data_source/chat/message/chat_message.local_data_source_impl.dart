import 'package:hive_flutter/hive_flutter.dart';
import 'package:hot_place/data/data_source/chat/message/chat_message.data_source.dart';
import 'package:hot_place/domain/model/chat/message/chat_message.local_model.dart';
import 'package:logger/logger.dart';

import '../../../../core/constant/hive.constant.dart';
import '../../../../core/error/custom_exception.dart';
import '../../../../core/error/failure.constant.dart';

class LocalChatMessageDataSourceImpl implements LocalChatMessageDataSource {
  bool _isInitialized = false;
  late Box<LocalChatMessageModel> _$box;
  final _logger = Logger();

  Future<Box<LocalChatMessageModel>> _getBox() async {
    if (!_isInitialized) {
      _$box = await Hive.openBox(BoxNames.message.name);
    }
    _isInitialized = true;
    return _$box;
  }

  @override
  Future<void> saveChatMessages(
      Iterable<LocalChatMessageModel> messages) async {
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
  Future<List<LocalChatMessageModel>> getChatMessages(String chatId,
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
