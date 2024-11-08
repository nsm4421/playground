part of 'usecase.dart';

class EditFeedUseCase {
  final FeedRepository _repository;

  EditFeedUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String id,
      String? content,
      List<String>? hashtags,
      List<String>? captions,
      List<File>? images}) async {
    return await _repository.edit(
        id: id,
        content: content,
        hashtags: hashtags,
        captions: captions,
        images: images);
  }
}
