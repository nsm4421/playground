part of 'datasource_impl.dart';

abstract class ReelsDataSource {
  Future<Iterable<FetchReelsDto>> fetchReels(
      {required DateTime beforeAt, int limit = 20});

  Future<void> createReels(CreateReelsDto dto);

  Future<void> editReels(EditReelsDto dto);

  Future<void> deleteReelsById(String reelsId);
}
