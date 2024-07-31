import 'package:injectable/injectable.dart';
import 'package:portfolio/features/feed/data/datasource/feed/feed.datasource_impl.dart';
import 'package:portfolio/features/feed/domain/entity/feed/feed.entity.dart';

import '../../../main/core/constant/response_wrapper.dart';

part '../../domain/repository/feed.repository.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource _dataSource;

  FeedRepositoryImpl(this._dataSource);

  @override
  Future<ResponseWrapper<void>> createFeed(FeedEntity entity) {
    // TODO: implement createFeed
    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<void>> deleteFeedById(String feedId) {
    // TODO: implement deleteFeedById
    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<List<FeedEntity>>> fetchFeeds(
      {required DateTime beforeAt, int take = 20, bool ascending = true}) {
    // TODO: implement fetchFeeds
    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<void>> modifyFeed(FeedEntity entity) {
    // TODO: implement modifyFeed
    throw UnimplementedError();
  }
}
