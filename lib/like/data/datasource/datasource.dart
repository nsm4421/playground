part of 'datasource_impl.dart';

abstract class LikeDataSource {
  Future<String> sendLike(SendLikeDto dto);

  Future<void> cancelLike(
      {required String referenceId, required Tables referenceTable});

  Future<void> cancelLikeById(String likeId);
}
