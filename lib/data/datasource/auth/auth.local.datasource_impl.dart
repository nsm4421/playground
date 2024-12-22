part of '../export.datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _key = "auth_user"; // key value to store user model in storage

  late StreamController<UserModel?> _controller;

  final FlutterSecureStorage _storage;
  final Logger _logger;

  AuthLocalDataSourceImpl(
      {required FlutterSecureStorage storage, required Logger logger})
      : _storage = storage,
        _logger = logger {
    _controller = StreamController<UserModel?>.broadcast();
  }

  @override
  Stream<UserModel?> get authStream => _controller.stream;

  @override
  Future<void> delete() async {
    await _storage.delete(key: _key);
    _controller.add(null);
  }

  @override
  Future<UserModel?> get() async => await _storage
      .read(key: _key)
      .then((res) => res == null ? null : UserModel.fromJson(json.decode(res)));

  @override
  Future<void> save(UserModel model) async {
    await _storage.write(key: _key, value: jsonEncode(model.toJson()));
    _controller.add(model);
  }
}
