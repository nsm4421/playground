part of '../../module/short/short.usecase.dart';

class SaveShortUseCase {
  final ShortRepository _repository;

  SaveShortUseCase(this._repository);

  Future<Either<Failure, void>> call(ShortEntity entity) async =>
      await _repository.saveShort(entity);
}
