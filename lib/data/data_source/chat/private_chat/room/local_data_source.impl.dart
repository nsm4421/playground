import 'package:hive/hive.dart';
import 'package:hot_place/domain/model/chat/private_chat/room/private_chat.local_model.dart';

import 'package:logger/logger.dart';

import '../../../../../core/constant/hive.constant.dart';
import '../../../../../core/error/custom_exception.dart';
import '../../../../../core/error/failure.constant.dart';
import '../../../../../core/util/exeption.util.dart';
import 'private_chat_room.data_source.dart';

class PrivateLocalChatDataSourceImpl implements LocalPrivateChatDataSource {
  bool _isInitialized = false;
  late Box<LocalPrivateChatModel> _$box;
  final _logger = Logger();

  Future<Box<LocalPrivateChatModel>> _getBox() async {
    if (!_isInitialized) {
      _$box = await Hive.openBox(BoxNames.privateChat.name);
    }
    _isInitialized = true;
    return _$box;
  }

  @override
  Future<void> deleteChat(String chatId) async {
    try {
      final box = await _getBox();
      await box.delete(chatId);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> saveChat(LocalPrivateChatModel chat) async {
    try {
      final box = await _getBox();
      await box.put(chat.id, chat);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
