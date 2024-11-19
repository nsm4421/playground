import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/data/model/error/error_response.dart';
import 'package:travel/domain/repository/repository.dart';

part 'feed.dart';

@lazySingleton
class EmotionUseCase {
  final EmotionRepository _repository;

  EmotionUseCase(this._repository);

  @lazySingleton
  SendLikeOnFeedUseCase get likeFeed => SendLikeOnFeedUseCase(_repository);

  @lazySingleton
  CancelLikeOnFeedUseCase get cancelFeed =>
      CancelLikeOnFeedUseCase(_repository);
}
