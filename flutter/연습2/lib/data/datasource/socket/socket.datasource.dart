part of '../export.datasource.dart';

abstract interface class SocketRemoteDataSource {
  Socket get socket;

  bool get initialized;

  void init(String token);

  void connect();

  void emit({required String event, required Map<String, dynamic> json});

  void onEvent(
      {required String event,
      required void Function(Map<String, dynamic> json) callback});

  void offEvent(String event);
}
