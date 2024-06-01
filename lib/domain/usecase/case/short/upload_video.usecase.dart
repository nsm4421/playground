part of '../../module/short/short.usecase.dart';

class UploadVideoUseCase {
  final ShortRepository _repository;

  UploadVideoUseCase(this._repository);

  Future<Either<Failure, void>> call(
          {required String id, required File video}) async =>
      await _repository.saveVideo(id: id, video: video);
}
