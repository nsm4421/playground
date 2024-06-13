part of 'package:my_app/data/repository_impl/like/like.repoistory_impl.dart';

abstract interface class LikeRepository {
  Stream<Iterable<String>> get likeOnFeedStream;

  Future<Either<Failure, void>> sendLikeOnFeed(String feedId);

  Future<Either<Failure, void>> cancelLikeOnFeed(String likeId);
}
