part of '../../module/short/short.usecase.dart';

class GetShortsUseCase {
  final ShortRepository _repository;

  GetShortsUseCase(this._repository);

  Future<Either<Failure, List<ShortEntity>>> call(
          {String? afterAt, int? take, bool? descending}) async =>
      await _repository.getShorts(
          afterAt: afterAt, take: take, descending: descending);
}
