part of 'usecase.dart';

class FetchReelsUseCase {
  final ReelsRepository _repository;

  FetchReelsUseCase(this._repository);

  Future<Either<ErrorResponse, List<ReelsEntity>>> call(
      {required DateTime beforeAt, int take = 20}) async {
    return await _repository.fetch(
        beforeAt: beforeAt.toUtc().toIso8601String(), take: take);
  }
}
