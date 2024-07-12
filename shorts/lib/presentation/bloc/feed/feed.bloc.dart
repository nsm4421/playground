import 'package:injectable/injectable.dart';
import 'package:my_app/domain/usecase/module/feed/feed.usecase.dart';
import 'package:my_app/presentation/bloc/feed/upload/upload_feed.cubit.dart';

import '../../../domain/usecase/module/like/like.usecase.dart';
import 'display/display_feed.bloc.dart';

@lazySingleton
class FeedBloc {
  final FeedUseCase _feedUseCase;
  final LikeUseCase _likeUseCase;

  FeedBloc({required FeedUseCase feedUseCase, required LikeUseCase likeUseCase})
      : _feedUseCase = feedUseCase,
        _likeUseCase = likeUseCase;

  @lazySingleton
  UploadFeedCubit get upload => UploadFeedCubit(_feedUseCase);

  @lazySingleton
  DisplayFeedBloc get display =>
      DisplayFeedBloc(feedUseCase: _feedUseCase, likeUseCase: _likeUseCase);
}
