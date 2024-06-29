import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/custom_exception.dart';
import '../../../core/exception/failure.dart';
import '../../datasource/feed/impl/like.remote_datasource_impl.dart';

part '../../../domain/repository/like/like.repository.dart';

@LazySingleton(as: LikeRepository)
class LikeRepositoryImpl implements LikeRepository {
  final RemoteLikeDataSource _remoteDataSource;

  LikeRepositoryImpl({required RemoteLikeDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Stream<Iterable<String>> get likeOnFeedStream =>
      _remoteDataSource.likeOnFeedStream.asyncMap((event) => event
          .map((like) => like.referenceId)
          .filter((feedId) => feedId.isNotEmpty));

  @override
  Future<Either<Failure, void>> sendLikeOnFeed(String feedId) async {
    try {
      return await _remoteDataSource.saveLikeOnFeed(feedId).then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> cancelLikeOnFeed(String feedId) async {
    try {
      return await _remoteDataSource.deleteLikeOnFeed(feedId).then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
