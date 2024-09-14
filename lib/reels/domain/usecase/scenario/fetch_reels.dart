part of '../usecase.dart';

class FetchReelsUseCase {
  final ReelsRepository _repository;

  FetchReelsUseCase(this._repository);

  Future<UseCaseResponseWrapper<List<ReelsEntity>>> call(
      {DateTime? beforeAt, int limit = 5}) async {
    return await _repository
        .fetchReels(
            beforeAt: (beforeAt ?? DateTime.now().toUtc()), limit: limit)
        .then(UseCaseResponseWrapper.from);
  }
}
