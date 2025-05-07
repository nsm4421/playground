part of '../export.datasource.dart';

class FeedReactionRemoteDataSourceImpl extends $ReactionDataSourceImpl
    implements FeedReactionRemoteDataSource {
  FeedReactionRemoteDataSourceImpl(
      {required super.dio, required super.logger, required super.showLog});

  ReactionReference get _ref => ReactionReference.feeds;

  @override
  Future<int> count(int feedId) async =>
      await super.$count(id: feedId, ref: _ref);

  @override
  Future<ReactionDto> create(int feedId) async =>
      await super.$create(id: feedId, ref: _ref);

  @override
  Future<void> delete(int feedId) async =>
      await super.$delete(id: feedId, ref: _ref);
}
