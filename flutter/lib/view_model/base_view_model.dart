import 'package:flutter/foundation.dart';
import 'package:flutter_prj/data/datasource/datasource_interface.dart';

import '../model/chat_model.dart';
import '../model/local_message_model.dart';

abstract class BaseViewModel {
  final IDataSource _dataSource;

  BaseViewModel(this._dataSource);

  @protected
  Future<void> addMessage(LocalMessage localMessage) async {
    if (!await _isExitingChat(localMessage.chatId)) await _dataSource.addMessage(localMessage);
    await _dataSource.addMessage(localMessage);
  }

  Future<bool> _isExitingChat(String chatId) async {
    return await _dataSource.findChat(chatId) != null;
  }

  Future<void> _createNewChat(String chatId) async {
    final chat = Chat(chatId);
    await _dataSource.addChat(chat);
  }
}
