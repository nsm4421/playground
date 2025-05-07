import 'package:injectable/injectable.dart';
import 'package:my_app/domain/repository/story.repository.dart';
import 'package:my_app/domain/usecase/base/remote.usecase.dart';

@singleton
class StoryUseCase {
  final StoryRepository _storyRepository;

  StoryUseCase(this._storyRepository);

  Future execute<T>({required RemoteUseCase useCase}) async =>
      await useCase(_storyRepository);
}
