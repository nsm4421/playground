part of '../export.datasource.dart';

abstract class ChatRemoteDataSource {
  Future<Pageable<GroupChatDto>> fetch({required int page, int pageSize = 20});

  Future<void> create({required String title, required List<String> hashtags});

  Future<void> delete(String chatId);
}
