part of 'repository.dart';

abstract interface class ReelsRepository {
  Future<Either<ErrorResponse, List<ReelsEntity>>> fetch(
      {required String beforeAt, int take = 20});

  Future<Either<ErrorResponse, void>> create(
      {required String id, String? caption, required File video});

  Future<Either<ErrorResponse, void>> edit(
      {required String id, String? caption});

  Future<Either<ErrorResponse, void>> delete(String id);
}
