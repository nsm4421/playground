part of 'datasource_impl.dart';

abstract class LikeDataSource {
  Future<String> saveLike(SaveLikeDto dto);

  Future<void> deleteLike(
      {required String referenceId, required Tables referenceTable});

  Future<void> deleteLikeById(String likeId);
}
