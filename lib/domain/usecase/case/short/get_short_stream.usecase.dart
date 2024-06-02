part of '../../module/short/short.usecase.dart';

class GetShortStreamUseCase {
  final ShortRepository _repository;

  GetShortStreamUseCase(this._repository);

  Stream<List<ShortEntity>> call() => _repository.shortStream;
}
