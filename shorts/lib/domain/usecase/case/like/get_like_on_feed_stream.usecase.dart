part of 'package:my_app/domain/usecase/module/like/like.usecase.dart';

class GetLikeOnFeedStream {
  final LikeRepository _repository;

  GetLikeOnFeedStream(this._repository);

  Stream<Iterable<String>> call() => _repository.likeOnFeedStream;
}
