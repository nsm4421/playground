part of '../export.datasource.dart';

abstract interface class FeedReactionRemoteDataSource {
  Future<int> count(int id);

  Future<ReactionDto> create(int id);

  Future<void> delete(int id);
}
