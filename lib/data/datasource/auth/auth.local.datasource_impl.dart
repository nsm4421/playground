part of '../export.datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  late StreamController<String?> _controller;
  String? _token;

  AuthLocalDataSourceImpl() {
    _controller = StreamController<String?>.broadcast();
    _controller.stream.listen((token) {
      _token = token;
    });
  }

  @override
  String? get token => _token;

  @override
  Stream<String?> get tokenStream => _controller.stream;

  @override
  void addData(String? accessToken) {
    _controller.add(accessToken);
  }
}
