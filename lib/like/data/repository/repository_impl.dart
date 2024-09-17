import 'package:flutter_app/like/data/datasource/datasource_impl.dart';
import 'package:flutter_app/like/data/dto/send_like.dto.dart';
import 'package:flutter_app/shared/constant/constant.export.dart';
import 'package:injectable/injectable.dart';

part 'repository.dart';

@LazySingleton(as: LikeRepository)
class LikeRepositoryImpl extends LikeRepository {
  final LikeDataSource _dataSource;

  LikeRepositoryImpl(this._dataSource);

  @override
  Future<RepositoryResponseWrapper<String>> sendLike(
      {required String referenceId, required Tables referenceTable}) async {
    try {
      switch (referenceTable) {
        case Tables.feeds:
        case Tables.likes:
          return await _dataSource
              .sendLike(SendLikeDto(
                  reference_id: referenceId, reference_table: referenceTable))
              .then((likeId) => RepositorySuccess<String>(likeId));
        default:
          throw UnimplementedError();
      }
    } on Exception catch (error) {
      return RepositoryError<String>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> cancelLike(
      {required String referenceId, required Tables referenceTable}) async {
    try {
      switch (referenceTable) {
        case Tables.feeds:
        case Tables.likes:
          return await _dataSource
              .cancelLike(
                  referenceId: referenceId, referenceTable: referenceTable)
              .then((likeId) => const RepositorySuccess<void>(null));
        default:
          throw UnimplementedError();
      }
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }
}
