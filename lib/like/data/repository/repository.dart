part of 'repository_impl.dart';

abstract class LikeRepository {
  Future<RepositoryResponseWrapper<String>> sendLike(
      {required String referenceId, required Tables referenceTable});

  Future<RepositoryResponseWrapper<void>> cancelLike(
      {required String referenceId, required Tables referenceTable});
}
