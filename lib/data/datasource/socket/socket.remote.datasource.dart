part of '../export.datasource.dart';

class SocketRemoteDataSourceImpl implements SocketRemoteDataSource {
  final Socket _socket;
  final Logger _logger;

  SocketRemoteDataSourceImpl({required Socket socket, required Logger logger})
      : _socket = socket,
        _logger = logger;

  @override
  Socket get socket => _socket;

  @override
  void connect() {
    _socket
      ..connect()
      ..onConnect((d) {
        _logger.d('connected to server\n$d');
      })
      ..onConnectError((e) {
        _logger.d('connection error:$e');
      })
      ..onError((e) {
        _logger.d('socket error:$e');
      })
      ..onDisconnect((d) {
        _logger.d('socket disconnected:$d');
      });
  }

  @override
  void emit({required String event, required Map<String, dynamic> json}) {
    if (_socket.disconnected) {
      this.connect();
    }
    _socket.emit(event, json);
  }

  @override
  void onEvent(
      {required String event,
      required void Function(Map<String, dynamic> json) callback}) {
    if (_socket.disconnected) {
      this.connect();
    }
    _socket.on(event, (data) => callback(data));
  }

  @override
  void offEvent(String event) {
    _socket.off(event);
  }
}
