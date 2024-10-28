import 'package:either_dart/either.dart';

import '../../../core/constant/constant.dart';
import '../../../core/response/error_response.dart';
import '../../../core/util/util.dart';
import '../../../data/datasource/comment/datasource.dart';
import '../../entity/comment/comment.dart';

part 'repository_impl.dart';

abstract interface class CommentRepository {
  Future<Either<ErrorResponse, List<CommentEntity>>> fetch(
      {required BaseEntity ref, required String beforeAt, int take = 20});

  Future<Either<ErrorResponse, String>> create(
      {required BaseEntity ref, required String content});

  Future<Either<ErrorResponse, void>> modifyById(
      {required String commentId, required String content});

  Future<Either<ErrorResponse, void>> deleteById(String commentId);
}
