part of '../export.datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _key =
      "access_token"; // key value to store user model in storage

  late StreamController<String?> _controller;

  final FlutterSecureStorage _storage;
  final Logger _logger;

  AuthLocalDataSourceImpl(
      {required FlutterSecureStorage storage, required Logger logger})
      : _storage = storage,
        _logger = logger {
    _controller = StreamController<String?>.broadcast();
  }

  @override
  Stream<String?> get tokenStream => _controller.stream;

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: _key);
    _controller.add(null);
  }

  @override
  Future<String?> getToken() async => await _storage.read(key: _key);

  @override
  Future<void> saveToken(String accessToken) async {
    await _storage.write(key: _key, value: accessToken);
    _controller.add(accessToken);
  }
}
