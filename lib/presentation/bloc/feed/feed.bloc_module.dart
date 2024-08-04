import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/domain/usecase/feed/feed.usecase_module.dart';
import 'package:portfolio/presentation/bloc/feed/create/comment/create_comment.cubit.dart';
import 'package:portfolio/presentation/bloc/feed/create/feed/create_feed.cubit.dart';
import 'package:portfolio/presentation/bloc/feed/display/comment/display_feed_comment.bloc.dart';
import 'package:portfolio/presentation/bloc/feed/display/feed/display_feed.bloc.dart';

import '../../../core/constant/status.dart';
import '../../../domain/usecase/emotion/emotion.usecase_module.dart';

part "feed.state.dart";

part "feed.event.dart";

@lazySingleton
class FeedBlocModule {
  final FeedUseCase _feedUseCase;
  final EmotionUseCase _emotionUseCase;

  FeedBlocModule(
      {required FeedUseCase feedUseCase,
      required EmotionUseCase emotionUseCase})
      : _feedUseCase = feedUseCase,
        _emotionUseCase = emotionUseCase;

  @lazySingleton
  CreateFeedCubit get createFeed => CreateFeedCubit(_feedUseCase);

  @lazySingleton
  CreateCommentCubit createComment(String feedId) =>
      CreateCommentCubit(feedId, useCase: _feedUseCase);

  @injectable
  DisplayFeedBloc get displayFeed => DisplayFeedBloc(
      feedUseCase: _feedUseCase, emotionUseCase: _emotionUseCase);

  @injectable
  DisplayFeedCommentBloc displayFeedComment(String feedId) =>
      DisplayFeedCommentBloc(feedId,
          feedUseCase: _feedUseCase, emotionUseCase: _emotionUseCase);
}
