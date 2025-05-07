import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';
import '../lib/chat.dart';
import 'util_for_test.dart';

void main() {
  RethinkDb db = RethinkDb();
  Connection connection;
  MessageService sut;

  setUp(() async {
    connection = await db.connect(host: '127.0.0.1', port: 28015);
    final encryption = EncryptionService(Encrypter(AES(Key.fromLength(32))));
    await createDatabase(db, connection);
    sut = MessageService(db, connection, encryption);
  });

  tearDown(() async {
    sut.dispose();
    await cleanDatabase(db, connection);
  });

  final sender =
      User.fromJson({'id': '1', 'active': true, 'lastSeen': DateTime.now()});

  final receiver =
      User.fromJson({'id': '2', 'active': true, 'lastSeen': DateTime.now()});

  test('if message sent successfully, then return true', () async {
    Message message = Message(
        from: sender.id,
        to: receiver.id,
        timestamp: DateTime.now(),
        contents: 'test message');
    final result = await sut.send(message);
    expect(result, true);
  });

  test('sending message works successfully', () async {
    sut.messages(user: receiver).listen(expectAsync1((message) {
          expect(message.to, receiver.id);
          expect(message.id, isNotEmpty);
        }, count: 2));
    Message firstMessage = Message(
        from: sender.id,
        to: receiver.id,
        timestamp: DateTime.now(),
        contents: 'test message');
    Message secondMessage = Message(
        from: sender.id,
        to: receiver.id,
        timestamp: DateTime.now(),
        contents: 'test message');
    await sut.send(firstMessage);
    await sut.send(secondMessage);
  });

  test('successfully subscribe and receive messages', () async {
    final contents = "test message for encryption";
    sut.messages(user: receiver).listen(expectAsync1((message) {
          expect(message.to, receiver.id);
          expect(message.id, isNotEmpty);
          expect(message.contents, contents);
        }, count: 2));

    Message message = Message(
      from: sender.id,
      to: receiver.id,
      timestamp: DateTime.now(),
      contents: contents,
    );

    Message secondMessage = Message(
      from: sender.id,
      to: receiver.id,
      timestamp: DateTime.now(),
      contents: contents,
    );

    await sut.send(message);
    await sut.send(secondMessage);
  });

  test('successfully subscribe and receive new messages ', () async {
    Message message = Message(
      from: sender.id,
      to: receiver.id,
      timestamp: DateTime.now(),
      contents: 'this is a message',
    );

    Message secondMessage = Message(
      from: sender.id,
      to: receiver.id,
      timestamp: DateTime.now(),
      contents: 'this is another message',
    );

    await sut.send(message);
    await sut.send(secondMessage).whenComplete(
          () => sut.messages(user: receiver).listen(
                expectAsync1((message) {
                  expect(message.to, receiver.id);
                }, count: 2),
              ),
        );
  });
}
