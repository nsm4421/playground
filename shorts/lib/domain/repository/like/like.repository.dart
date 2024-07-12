part of 'package:my_app/data/repository_impl/like/like.repoistory_impl.dart';

abstract interface class LikeRepository {
  Stream<Iterable<String>> get likeOnFeedStream;

  Future<Either<Failure, void>> sendLike(
      {required String referenceId, required LikeType type});

  Future<Either<Failure, void>> deleteLike(
      {required String referenceId, required LikeType type});

  Future<Either<Failure, void>> deleteLikeById(String likeId);
}
