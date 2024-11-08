part of 'usecase.dart';

class CreateFeedUseCase {
  final FeedRepository _repository;

  CreateFeedUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String id,
      required String content,
      required List<String> hashtags,
      required List<String> captions,
      required List<File> images}) async {
    return await _repository.create(
        id: id,
        content: content,
        hashtags: hashtags,
        captions: captions,
        images: images);
  }
}
