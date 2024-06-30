import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/domain/model/like/delete_like_request.dto.dart';
import 'package:my_app/domain/model/like/save_like_request.dto.dart';

import '../../../core/constant/dto.constant.dart';
import '../../../core/exception/custom_exception.dart';
import '../../../core/exception/failure.dart';
import '../../datasource/feed/impl/like.remote_datasource_impl.dart';

part '../../../domain/repository/like/like.repository.dart';

@LazySingleton(as: LikeRepository)
class LikeRepositoryImpl implements LikeRepository {
  final RemoteLikeDataSource _remoteDataSource;

  LikeRepositoryImpl({required RemoteLikeDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Stream<Iterable<String>> get likeOnFeedStream =>
      _remoteDataSource.likeOnFeedStream.asyncMap((event) =>
          event.map((dto) => dto.feedId).filter((feedId) => feedId.isNotEmpty));

  @override
  Future<Either<Failure, void>> sendLike(
      {required String referenceId, required LikeType type}) async {
    try {
      return await _remoteDataSource
          .saveLike(SaveLikeRequestDto(referenceId: referenceId, type: type))
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLike(
      {required String referenceId, required LikeType type}) async {
    try {
      return await _remoteDataSource
          .deleteLike(
              DeleteLikeRequestDto(referenceId: referenceId, type: type))
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLikeById(String likeId) async {
    try {
      return await _remoteDataSource.deleteLikeById(likeId).then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
