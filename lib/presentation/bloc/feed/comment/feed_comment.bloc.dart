import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/feed/base/feed.entity.dart';
import 'package:my_app/presentation/bloc/feed/comment/upload/upload_feed_comment.cubit.dart';

import '../../../../domain/usecase/module/feed/feed_comment.usecase.dart';
import 'display/display_feed_comment.bloc.dart';

@injectable
class FeedCommentBloc {
  final FeedEntity _feed;
  final FeedCommentUseCase _useCase;

  FeedCommentBloc(@factoryParam this._feed,
      {required FeedCommentUseCase useCase})
      : _useCase = useCase {
    assert(_feed.id != null);
  }

  @injectable
  DisplayFeedCommentBloc get display =>
      DisplayFeedCommentBloc(feed: _feed, useCase: _useCase);

  @injectable
  UploadFeedCommentCubit get upload =>
      UploadFeedCommentCubit(feed:_feed, useCase: _useCase);
}
