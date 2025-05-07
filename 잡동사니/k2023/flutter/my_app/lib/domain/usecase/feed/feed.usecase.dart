import 'package:injectable/injectable.dart';

import '../../repository/feed.repository.dart';
import '../base/remote.usecase.dart';

@singleton
class FeedUseCase {
  final FeedRepository _feedRepository;

  FeedUseCase(this._feedRepository);

  Future execute<T>({required RemoteUseCase useCase}) async =>
      await useCase(_feedRepository);
}
