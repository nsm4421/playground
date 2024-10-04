part of '../usecase.dart';

class EditDiaryUseCase {
  final DiaryRepository _repository;

  EditDiaryUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call({
    required String id,
    String? location,
    required List<String> hashtags,
    required List<File?> images,
    required List<String> captions,
    required bool isPrivate,
    bool update = false, // true->create, false->edit
  }) async {
    return await _repository.edit(
        id: id,
        hashtags: hashtags,
        images: images,
        captions: captions,
        isPrivate: isPrivate,
        update: update);
  }
}

class DeleteDiaryUseCase {
  final DiaryRepository _repository;

  DeleteDiaryUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String id) async {
    return await _repository.delete(id);
  }
}
