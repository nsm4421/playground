part of 'usecase.dart';

class DeleteReelsUseCase {
  final ReelsRepository _repository;

  DeleteReelsUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String id) async {
    return await _repository.delete(id);
  }
}
