import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/feed/feed.entity.dart';
import 'package:my_app/presentation/bloc/feed/comment/upload/upload_feed_comment.cubit.dart';

import '../../../../data/entity/feed/feed_comment.entity.dart';
import '../../../../domain/usecase/module/feed/feed_comment.usecase.dart';

part 'display/display_feed_comment.state.dart';

part 'display/display_feed_comment.event.dart';

part 'display/display_feed_comment.bloc.dart';

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
      DisplayFeedCommentBloc(_feed.id!, useCase: _useCase);

  @injectable
  UploadFeedCommentCubit get upload =>
      UploadFeedCommentCubit(_feed.id!, useCase: _useCase);
}
