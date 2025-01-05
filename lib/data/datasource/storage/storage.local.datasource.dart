part of '../export.datasource.dart';

class StorageLocalDataSourceImpl implements StorageLocalDataSource {
  final FlutterSecureStorage _storage;
  final Logger _logger;

  StorageLocalDataSourceImpl(
      {required FlutterSecureStorage storage, required Logger logger})
      : _storage = storage,
        _logger = logger;

  @override
  Future<void> delete(String key) async {
    _logger.d('delete|key:$key');
    return await _storage.delete(key: key);
  }

  @override
  Future<String?> get(String key) async {
    final value = await _storage.read(key: key);
    _logger.d('get|key:$key|value:$value');
    return value;
  }

  @override
  Future<void> save({required String key, required String value}) async {
    _logger.d('save|key:$key|value:$value');
    return await _storage.write(key: key, value: value);
  }
}
