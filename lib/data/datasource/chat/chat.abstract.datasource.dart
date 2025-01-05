part of '../export.datasource.dart';

abstract class ChatRemoteDataSource {
  Future<void> create({required String title, required List<String> hashtags});
}
