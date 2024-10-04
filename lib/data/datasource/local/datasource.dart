import 'package:hive_flutter/hive_flutter.dart';

part 'datasource_impl.dart';

abstract interface class LocalDataSource {
  Future<void> saveEmailAndPassword(String email, String password);

  Future<Map<String, String?>> getEmailAndPassword();

  Future<void> deleteEmailAndPassword();
}
