part of '../export.datasource.dart';

abstract interface class StorageLocalDataSource {
  Future<String?> get(String key);

  Future<void> save({required String key, required String value});

  Future<void> delete(String key);
}
