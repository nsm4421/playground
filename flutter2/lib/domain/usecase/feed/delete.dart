part of 'usecase.dart';

class DeleteFeedUseCase {
  final FeedRepository _repository;

  DeleteFeedUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String id) async {
    return await _repository.delete(id);
  }
}
