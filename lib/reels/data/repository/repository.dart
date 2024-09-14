part of 'repository_impl.dart';

abstract class ReelsRepository {
  Future<RepositoryResponseWrapper<List<ReelsEntity>>> fetchReels(
      {required DateTime beforeAt, int limit = 5});

  Future<RepositoryResponseWrapper<void>> createReels(
      {required String reelsId,
      required String media,
      required String caption});

  Future<RepositoryResponseWrapper<void>> editReels(
      {required String reelsId, String? media, String? caption});

  Future<RepositoryResponseWrapper<void>> deleteReelsById(String reelsId);

  Future<RepositoryResponseWrapper<String>> uploadReelsVideo(File video,
      {bool upsert = false});
}
