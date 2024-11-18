part of 'repository.dart';

abstract interface class FeedRepository {
  Future<Either<ErrorResponse, List<FeedEntity>>> fetch(
      {required String beforeAt, int take = 20});

  Future<Either<ErrorResponse, void>> create(
      {required String id,
      required List<String> hashtags,
      required List<String> captions,
      required List<File> images});

  Future<Either<ErrorResponse, void>> edit(
      {required String id,
      List<String>? hashtags,
      List<String>? captions,
      List<File>? images});

  Future<Either<ErrorResponse, void>> delete(String id);
}
