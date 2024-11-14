part of 'usecase.dart';

class CreateReelsUseCase {
  final ReelsRepository _repository;

  CreateReelsUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String id, required File video, String? caption}) async {
    return await _repository.create(id: id, video: video, caption: caption);
  }
}
