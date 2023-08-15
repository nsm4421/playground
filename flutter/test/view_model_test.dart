import 'package:chat/chat.dart';
import 'package:flutter_prj/data/datasource/datasource_interface.dart';
import 'package:flutter_prj/model/chat_model.dart';
import 'package:flutter_prj/view_model/chats_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataSource extends Mock implements IDataSource {}

void main() {
  MockDataSource db;
  ChatsViewModel sut;

  setUp((){
     db = MockDataSource();
     sut = ChatsViewModel(db);
  });

  final message = Message.fromJson({
    'from': 'sender id',
    'to': 'receiver id',
    'contents': 'test message',
    'timestamp': DateTime.parse('2023-03-03'),
    'id': '1234'
  });

  test('findAllChat method return empty list', () async {
    when(db.findAllChat()).thenAnswer((_) async => []);
    expect(await sut.getChats(), isEmpty);
  });

  test('if i added chat, findAllChat method return non-empty list', () async {
    final chat = Chat('test chat id');
    when(db.findAllChat()).thenAnswer((_) async => [chat]);
    final chats = await sut.getChats();
    expect(chats, isNotEmpty);
  });
}
