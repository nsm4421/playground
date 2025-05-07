part of '../export.datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  late StreamController<String?> _controller;
  final Logger _logger;
  final bool _showLog;
  String? _token;

  AuthLocalDataSourceImpl({required Logger logger, required bool showLog})
      : _logger = logger,
        _showLog = showLog {
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
    if (_showLog) _logger.t(accessToken);
  }
}
