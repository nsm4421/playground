part of 'usecase.dart';

class EditFeedUseCase {
  final FeedRepository _repository;

  EditFeedUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String id,
      List<String>? hashtags,
      List<String>? captions,
      List<File>? images}) async {
    return await _repository.edit(
        id: id,
        hashtags: hashtags,
        captions: captions,
        images: images);
  }
}
