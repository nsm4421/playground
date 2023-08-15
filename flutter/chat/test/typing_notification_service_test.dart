import 'package:rethink_db_ns/rethink_db_ns.dart';

import '../lib/chat.dart';

import 'package:flutter_test/flutter_test.dart';

import 'util_for_test.dart';

void main() {
  RethinkDb db = RethinkDb();
  Connection connection;
  TypingNotificationService sut;

  setUp(() async {
    connection = await db.connect();
    createDatabase(db, connection);
    sut = TypingNotificationService(db, connection);
  });

  tearDown(() async {
    cleanDatabase(db, connection);
  });

  final sender =
      User.fromJson({'id': '1', 'active': true, 'lastSeen': DateTime.now()});

  final receiver =
      User.fromJson({'id': '2', 'active': true, 'lastSeen': DateTime.now()});

  test('if sending typing notification successfully, then return true',
      () async {
    TypingEvent event =
        TypingEvent(from: sender.id, to: receiver.id, event: Typing.start);
    final result = await sut.send(event: event, to: receiver);
    expect(result, true);
  });
}
