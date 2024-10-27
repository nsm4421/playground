import 'package:either_dart/either.dart';
import 'package:travel/data/datasource/like/datasource.dart';

import '../../../core/constant/constant.dart';
import '../../../core/response/error_response.dart';
import '../../../core/util/util.dart';

part 'repository_impl.dart';

abstract interface class LikeRepository {
  Future<Either<ErrorResponse, void>> create(BaseEntity ref);

  Future<Either<ErrorResponse, void>> delete(BaseEntity ref);
}
