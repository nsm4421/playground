part of '../export.datasource.dart';

class SocketRemoteDataSourceImpl implements SocketRemoteDataSource {
  late Socket _socket;
  final Logger _logger;
  final bool _showLog;
  bool _initialized = false;
  String? _token;

  SocketRemoteDataSourceImpl({required Logger logger, required bool showLog})
      : _logger = logger,
        _showLog = showLog;

  @override
  Socket get socket => _socket;

  @override
  bool get initialized => _initialized;

  @override
  void init(String token) {
    if (_initialized && token == _token) return;
    _initialized = true;
    _token = token;
    _socket = io(
        ApiEndPoint.socketUrl,
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({'Authorization': _token})
            .build());
    if (_showLog) _logger.t('socket initialized');
  }

  @override
  void connect() {
    _socket.connect();
    if (_showLog) {
      _socket
        ..onConnect((d) {
          _logger.t('connected to server\n$d');
        })
        ..onConnectError((e) {
          _logger.t('connection error:$e');
        })
        ..onError((e) {
          _logger.t('socket error:$e');
        })
        ..onDisconnect((d) {
          _logger.t('socket disconnected:$d');
        });
    }
  }

  @override
  void emit({required String event, required Map<String, dynamic> json}) {
    if (_socket.disconnected) {
      this.connect();
    }
    _socket.emit(event, json);
    if (_showLog) _logger.t('emit|event:$event/payload:${json.toString()}');
  }

  @override
  void onEvent(
      {required String event,
      required void Function(Map<String, dynamic> json) callback}) {
    if (_socket.disconnected) {
      this.connect();
    }
    _socket.on(event, (data) => callback(data));
    if (_showLog) _logger.t('onEvent|event:$event');
  }

  @override
  void offEvent(String event) {
    _socket.off(event);
    if (_showLog) _logger.t('offEvent|event:$event');
  }
}
