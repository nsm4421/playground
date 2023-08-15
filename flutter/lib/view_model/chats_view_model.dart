import 'package:chat/chat.dart';
import 'package:flutter_prj/data/datasource/datasource_interface.dart';
import 'package:flutter_prj/model/chat_model.dart';
import 'package:flutter_prj/model/local_message_model.dart';
import 'package:flutter_prj/view_model/base_view_model.dart';

class ChatsViewModel extends BaseViewModel {
  final IDataSource _dataSource;

  ChatsViewModel(this._dataSource) : super(_dataSource);

  Future<List<Chat>> getChats() async => await _dataSource.findAllChat();

  Future<void> receiveMessage(Message message) async {
    LocalMessage localMessage =
        LocalMessage(message.from, message, ReceiptStatus.delivered);
    await addMessage(localMessage);
  }
}
