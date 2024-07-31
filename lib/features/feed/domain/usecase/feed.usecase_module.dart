import 'package:injectable/injectable.dart';
import 'package:portfolio/features/feed/data/repository_impl/feed.repository_impl.dart';

@lazySingleton
class FeedUseCase {
  final FeedRepository _repository;

  FeedUseCase(this._repository);
}
