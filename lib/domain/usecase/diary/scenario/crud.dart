part of '../usecase.dart';

class EditDiaryUseCase {
  final DiaryRepository _repository;

  EditDiaryUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call({
    required String id,
    String? location,
    required String content,
    required List<String> hashtags,
    required List<File?> images,
    required List<String> captions,
    required bool isPrivate,
    bool update = false, // true->create, false->edit
  }) async {
    return await _repository
        .edit(
            id: id,
            content: content,
            location: location,
            hashtags: hashtags,
            images: images,
            captions: captions,
            isPrivate: isPrivate,
            update: update)
        .then((res) => res.mapLeft((l) => l.copyWith(
            message: 'fail to ${update ? 'modify' : 'create'} diary')));
  }
}

class FetchDiariesUseCase {
  final DiaryRepository _repository;

  FetchDiariesUseCase(this._repository);

  Future<Either<ErrorResponse, List<DiaryEntity>>> call(String beforeAt,
      {int take = 20}) async {
    return await _repository.fetch(beforeAt, take: take).then((res) =>
        res.mapLeft((l) => l.copyWith(message: 'fail to fetch diaries')));
  }
}

class DeleteDiaryUseCase {
  final DiaryRepository _repository;

  DeleteDiaryUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String id) async {
    return await _repository.delete(id).then((res) =>
        res.mapLeft((l) => l.copyWith(message: 'fail to delete diary')));
  }
}
