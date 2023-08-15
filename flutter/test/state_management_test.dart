import 'package:chat/chat.dart';
import 'package:flutter_prj/states_management/message/message_bloc.dart';
import 'package:flutter_prj/states_management/message/message_event.dart';
import 'package:flutter_prj/states_management/message/message_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockMessageService extends Mock implements IMessageService {}

void main() {
  MessageBloc sut;
  IMessageService messageService;
  User user;

  setUp(() {
    messageService = MockMessageService();
    user = User(
        username: 'test username',
        photoUrl: 'test photo url',
        active: true,
        lastSeen: DateTime.now());
    sut = MessageBloc(messageService);
  });

  tearDown(() {
    sut.close();
  });

  test('should emit initial only without subscription ', () {
    expect(sut.state, MessageInitial());
  });

  test('should emit message sent state when message is sent', () {
    final message = Message(
        from: 'sender id',
        to: 'receiver id',
        contents: 'test',
        timestamp: DateTime.now());
    when(messageService.send(message)).thenAnswer((_) async => true);
    sut.add(MessageEvent.onMessageSent(message));
    expectLater(sut.stream, emits(MessageState.sent(message)));
  });
}
