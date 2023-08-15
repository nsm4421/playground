import 'package:rethink_db_ns/rethink_db_ns.dart';

String databaseName = 'test_for_image_upload';

void main() async {
  RethinkDb db = RethinkDb();
  Connection connection = await db.connect(host: "127.0.0.1", port: 28015);
  await db.dbCreate(databaseName).run(connection).catchError(print);
  await db.tableCreate('users').run(connection).catchError(print);
}