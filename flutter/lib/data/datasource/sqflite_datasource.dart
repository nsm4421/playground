import 'package:flutter_prj/data/datasource/datasource_interface.dart';
import 'package:flutter_prj/model/chat_model.dart';
import 'package:flutter_prj/model/local_message_model.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDataSource implements IDataSource {
  final Database _db;

  const SqfliteDataSource(this._db);

  final queryForUnread = '''
    SELECT CHAT_ID, COUNT(*) AS UNREAD FROM MESSAGES
    WHERE RECEIPT_STATUS = ?
    GROUP BY CHAT_ID
     ''';
  final queryForLatestMessage = '''
      SELECT MESSAGES.* FROM (
        SELECT CHAT_ID, MAX(CREATED_AT) AS CREATED_AT 
        FROM MESSAGES
        GROUP BY CHAT_ID
      ) AS LATEST_MESSAGES 
      INNER JOIN MESSAGES
      ON MESSAGES.CHAT_ID = LATEST_MESSAGES.CHAT_ID
      AND MESSAGE.CREATED_AT = LATEST_MESSAGES.CREATED_AT
      ''';

  @override
  Future<void> addChat(Chat chat) async {
    await _db.insert('chats', chat.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> addMessage(LocalMessage message) async {
    await _db.insert('messages', message.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Chat>> findAllChat() {
    return _db.transaction((txn) async {
      final chatsWithLatestMessage = await txn.rawQuery(queryForLatestMessage);
      if (chatsWithLatestMessage.isEmpty) return [];
      final chatWithUnreadMessages =
          await txn.rawQuery(queryForUnread, ['delivered']);
      return chatsWithLatestMessage.map<Chat>((row) {
        final int unread = int.tryParse(chatWithUnreadMessages.firstWhere(
            (element) => (row['chat_id'] == element['chat_id']),
            orElse: () => {'unread': 0})['unread']);
        final chat = Chat.fromMap(row);
        chat.unread = unread;
        chat.mostRecent = LocalMessage.fromMap(row);
        return chat;
      }).toList();
    });
  }

  @override
  Future<Chat> findChat(String chatId) async {
    return await _db.transaction((txn) async {
      final listOfChatMaps =
          await txn.query('chat', where: 'CHAT_ID = ?', whereArgs: [chatId]);
      if (listOfChatMaps.isNotEmpty) return null;
      final unread = Sqflite.firstIntValue(
          await txn.rawQuery(queryForUnread, [chatId, 'delivered']));
      final mostRecentMessage = await txn.query('messages',
          where: 'CHAT_ID = ?',
          whereArgs: [chatId],
          orderBy: 'CREATED_AT DESC',
          limit: 1);
      final chat = Chat.fromMap(listOfChatMaps.first);
      chat.unread = unread;
      chat.mostRecent = LocalMessage.fromMap(mostRecentMessage.first);
      return chat;
    });
  }

  @override
  Future<List<LocalMessage>> findMessages(String chatId) async {
    final listOfMaps =
        await _db.query('messages', where: 'CHAT_ID = ?', whereArgs: [chatId]);
    return listOfMaps
        .map<LocalMessage>((map) => LocalMessage.fromMap(map))
        .toList();
  }

  @override
  Future<void> updateMessage(LocalMessage localMessage) async {
    _db.update('messages', localMessage.toMap(),
        where: 'ID = ?',
        whereArgs: [localMessage.message.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteChat(String chatId) async {
    final batch = _db.batch();
    batch.delete('messages', where: 'CHAT_ID = ?', whereArgs: [chatId]);
    batch.delete('chats', where: 'ID = ?', whereArgs: [chatId]);
    await batch.commit(noResult: true);
  }
}
