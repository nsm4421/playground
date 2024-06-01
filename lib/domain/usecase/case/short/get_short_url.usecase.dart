part of '../../module/short/short.usecase.dart';

class GetShortUrlUseCase {
  final ShortRepository _repository;

  GetShortUrlUseCase(this._repository);

  Future<Either<Failure, String>> call(String id) async =>
      await _repository.getShortDownloadUrl(id);
}
