import 'package:injectable/injectable.dart';
import 'package:my_app/repository/feed/feed.repository.dart';

import '../base/remote.usecase.dart';

@singleton
class FeedUsecase {
  final FeedRepository _feedRepository;

  FeedUsecase(this._feedRepository);

  Future execute<T>({required RemoteUsecase useCase}) async =>
      await useCase(_feedRepository);
}
