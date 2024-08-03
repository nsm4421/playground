import 'package:injectable/injectable.dart';
import 'package:portfolio/domain/usecase/feed/feed.usecase_module.dart';
import 'package:portfolio/presentation/bloc/feed/create/create_feed.cubit.dart';

@lazySingleton
class FeedBlocModule {
  final FeedUseCase _feedUseCase;

  FeedBlocModule(this._feedUseCase);

  @lazySingleton
  CreateFeedCubit get create => CreateFeedCubit(_feedUseCase);
}
