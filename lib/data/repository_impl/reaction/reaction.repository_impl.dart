part of '../export.repository_impl.dart';

@LazySingleton(as: ReactionRepository)
class ReactionRepositoryImpl with LoggerUtil implements ReactionRepository {
  final ReactionRemoteDataSource _remoteDataSource;

  ReactionRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<ErrorResponse, SuccessResponse<int>>> count(
      {required int id, required ReactionReference ref}) async {
    try {
      return await _remoteDataSource
          .count(id: id, ref: ref)
          .then((res) => SuccessResponse(payload: res))
          .then(Right.new);
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<ReactionEntity>>> create(
      {required int id, required ReactionReference ref}) async {
    try {
      return await _remoteDataSource
          .create(id: id, ref: ref)
          .then(ReactionEntity.from)
          .then((entity) => SuccessResponse(payload: entity))
          .then(Right.new);
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> delete(
      {required int id, required ReactionReference ref}) async {
    try {
      return await _remoteDataSource
          .delete(id: id, ref: ref)
          .then((_) => SuccessResponse(payload: null))
          .then(Right.new);
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }
}
