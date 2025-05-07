import 'package:flutter_test/flutter_test.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';
import '../lib/chat.dart';
import 'util_for_test.dart';

void main() {
  RethinkDb db = RethinkDb();
  Connection connection;
  ReceiptService sut;

  setUp(() async {
    connection = await db.connect(host: '127.0.0.1', port: 28015);
    await createDatabase(db, connection);
    sut = ReceiptService(db, connection);
  });

  tearDown(() async {
    sut.dispose();
    await cleanDatabase(db, connection);
  });

  final user =
      User.fromJson({'id': '2', 'active': true, 'lastSeen': DateTime.now()});

  test('if receipt sent successfully, then return true', () async {
    Receipt receipt = Receipt(
        recipient: '444',
        messageId: '12',
        status: ReceiptStatus.delivered,
        timestamp: DateTime.now());
    final result = await sut.send(receipt);
    expect(result, true);
  });

  test('sending receipt works successfully', () async {
    sut.receipts(user).listen(expectAsync1((receipt) {
          expect(receipt.recipient, user.id);
        }, count: 2));
    Receipt receipt1 = Receipt(
        recipient: user.id,
        messageId: "1234",
        status: ReceiptStatus.delivered,
        timestamp: DateTime.now());
    Receipt receipt2 = Receipt(
        recipient: user.id,
        messageId: "12345",
        status: ReceiptStatus.delivered,
        timestamp: DateTime.now());

    await sut.send(receipt1);
    await sut.send(receipt2);
  });
}
