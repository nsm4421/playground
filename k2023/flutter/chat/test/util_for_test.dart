import 'package:rethink_db_ns/rethink_db_ns.dart';

String databaseName = 'test';
List<String> tablesNames = ["users", "messages", "receipts", "typing_events"];

Future<void> createDatabase(RethinkDb db, Connection connection) async {
  await db.dbCreate(databaseName).run(connection).catchError(print);
  for (String tn in tablesNames) {
    await db.tableCreate(tn).run(connection).catchError(print);
  }
}

Future<void> cleanDatabase(RethinkDb db, Connection connection) async {
  for (String tn in tablesNames) {
    await db.table(tn).delete().run(connection);
  }
}
