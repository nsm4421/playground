part of '../export.datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  late StreamController<String?> _controller;

  AuthLocalDataSourceImpl() {
    _controller = StreamController<String?>.broadcast();
  }

  @override
  Stream<String?> get tokenStream => _controller.stream;

  @override
  void addData(String? accessToken) {
    _controller.add(accessToken);
  }
}
