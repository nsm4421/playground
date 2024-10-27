import 'package:either_dart/either.dart';

import '../../../core/constant/constant.dart';
import '../../../core/response/error_response.dart';
import '../../repository/like/repository.dart';

part 'scenario/crud.dart';

class LikeUseCase {
  final LikeRepository _repository;

  LikeUseCase(this._repository);

  CreateLikeUseCase like(BaseEntity ref) =>
      CreateLikeUseCase(_repository, ref: ref);

  CancelLikeUseCase cancel(BaseEntity ref) =>
      CancelLikeUseCase(_repository, ref: ref);
}
