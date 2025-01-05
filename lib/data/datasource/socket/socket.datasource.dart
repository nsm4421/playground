part of '../export.datasource.dart';

abstract interface class SocketRemoteDataSource {
  Socket get socket;

  void connect();

  void emit({required String event, required Map<String, dynamic> json});

  void onEvent(
      {required String event,
      required void Function(Map<String, dynamic> json) callback});

  void offEvent(String event);
}
