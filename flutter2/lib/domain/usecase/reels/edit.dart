part of 'usecase.dart';

class EditReelsUseCase {
  final ReelsRepository _repository;

  EditReelsUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String id, String? caption}) async {
    return await _repository.edit(id: id, caption: caption);
  }
}
