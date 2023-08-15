import 'package:chat/chat.dart';
import 'package:flutter_prj/data/datasource/sqflite_datasource.dart';
import 'package:flutter_prj/model/chat_model.dart';
import 'package:flutter_prj/model/local_message_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

class MockSqfliteDatabase extends Mock implements Database {}

class MockBatch extends Mock implements Batch {}

void main() {
  SqfliteDataSource sut;
  MockSqfliteDatabase db;
  MockBatch batch;

  setUp(() {
    db = MockSqfliteDatabase();
    batch = MockBatch();
    sut = SqfliteDataSource(db);
  });

  final message = Message.fromJson({
    'from': 'A',
    'to': 'B',
    'contents': 'hi',
    'timestamp': DateTime.parse('2023-03-02'),
    'id': 'C'
  });

  test('when insert a chat data into chat table successfully, then return 1',
      () async {
    final chat = Chat('1234');
    when(db.insert('chat', chat.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace))
        .thenAnswer((_) async => 1);
    await sut.addChat(chat);
    verify(db.insert('chats', chat.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace))
        .called(1);
  });

  test(
      'when insert a local message into message table successfully, then return 1',
      () async {
    final localMessage = LocalMessage('1234', message, ReceiptStatus.delivered);
    when(db.insert('messages', localMessage.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace))
        .thenAnswer((_) async => 1);
    await sut.addMessage(localMessage);
    verify(db.insert('messages', localMessage.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace))
        .called(1);
  });

  test('find message by chat id', () async {
    //arrange
    final messagesMap = [
      {
        'chat_id': '111',
        'id': '4444',
        'from': '111',
        'to': '222',
        'contents': 'hey',
        'status': 'sent',
        'timestamp': DateTime.parse("2021-04-01"),
      }
    ];
    when(db.query(
      'messages',
      where: anyNamed('where'),
      whereArgs: anyNamed('whereArgs'),
    )).thenAnswer((_) async => messagesMap);

    //act
    var messages = await sut.findMessages('111');

    //assert
    expect(messages.length, 1);
    expect(messages.first.chatId, '111');
    verify(db.query(
      'messages',
      where: anyNamed('where'),
      whereArgs: anyNamed('whereArgs'),
    )).called(1);
  });
}
