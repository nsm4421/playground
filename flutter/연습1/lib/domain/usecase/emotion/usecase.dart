import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/data/model/error/error_response.dart';
import 'package:travel/domain/repository/repository.dart';

part 'crud.dart';

@lazySingleton
class EmotionUseCase {
  final EmotionRepository _repository;

  EmotionUseCase(this._repository);

  @lazySingleton
  SendLikeOnUseCase get like => SendLikeOnUseCase(_repository);

  @lazySingleton
  CancelLikeOnUseCase get cancel => CancelLikeOnUseCase(_repository);
}
