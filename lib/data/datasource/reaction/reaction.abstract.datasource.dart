part of '../export.datasource.dart';

abstract interface class ReactionRemoteDataSource {
  Future<int> count({required int id, required ReactionReference ref});

  Future<ReactionDto> create({required int id, required ReactionReference ref});

  Future<void> delete({required int id, required ReactionReference ref});
}
