import 'package:injectable/injectable.dart';

import '../../domain/entity/comment/comment.dart';
import '../../domain/entity/feed/feed.dart';
import '../../domain/entity/meeting/meeting.dart';
import '../../domain/usecase/usecase_module.dart';
import 'auth/authentication.bloc.dart';
import 'bottom_nav/home_bottom_nav.cubit.dart';
import 'comment/display/display_comment.bloc.dart';
import 'comment/edit/edit_comment.bloc.dart';
import 'feed/display/display_feed.bloc.dart';
import 'feed/edit/edit_feed.bloc.dart';
import 'image_to_text/image_to_text.bloc.dart';
import 'like/like.cubit.dart';
import 'meeting/create/create_meeting.cubit.dart';
import 'meeting/display/display_meeting.bloc.dart';
import 'registration/display/display_registration.bloc.dart';
import 'registration/edit/edit_registration.bloc.dart';

@lazySingleton
class BlocModule {
  final UseCaseModule _useCaseModule;

  BlocModule(this._useCaseModule);

  /// view
  @lazySingleton
  HomeBottomNavCubit get nav => HomeBottomNavCubit();

  /// auth & account
  @lazySingleton
  AuthenticationBloc get auth => AuthenticationBloc(
      authUseCase: _useCaseModule.auth, accountUseCase: _useCaseModule.account);

  /// feed
  @injectable
  EditFeedBloc editFeed(String id) =>
      EditFeedBloc(id: id, useCase: _useCaseModule.feed);

  @lazySingleton
  DisplayFeedBloc get displayFeed => DisplayFeedBloc(_useCaseModule.feed);

  /// meeting
  @lazySingleton
  CreateMeetingCubit get createMeeting =>
      CreateMeetingCubit(_useCaseModule.meeting);

  @lazySingleton
  DisplayMeetingBloc get displayMeeting =>
      DisplayMeetingBloc(_useCaseModule.meeting);

  /// registration on meeting
  @injectable
  DisplayRegistrationBloc displayRegistration(MeetingEntity meeting) =>
      DisplayRegistrationBloc(meeting, useCase: _useCaseModule.registration);

  @injectable
  EditRegistrationBloc editRegistration(MeetingEntity meeting) =>
      EditRegistrationBloc(meeting, useCase: _useCaseModule.registration);

  /// comment
  @injectable
  DisplayCommentBloc<FeedEntity> displayFeedComment(FeedEntity feed) =>
      DisplayCommentBloc<FeedEntity>(feed, useCase: _useCaseModule.comment);

  @injectable
  EditCommentBloc<FeedEntity> editFeedComment(FeedEntity feed) =>
      EditCommentBloc<FeedEntity>(feed, useCase: _useCaseModule.comment);

  @injectable
  DisplayCommentBloc<MeetingEntity> displayMeetingComment(
          MeetingEntity meeting) =>
      DisplayCommentBloc<MeetingEntity>(meeting,
          useCase: _useCaseModule.comment);

  @injectable
  EditCommentBloc<MeetingEntity> editMeetingComment(MeetingEntity meeting) =>
      EditCommentBloc<MeetingEntity>(meeting, useCase: _useCaseModule.comment);

  /// like
  @injectable
  LikeCubit<FeedEntity> likeFeed(FeedEntity feed) =>
      LikeCubit<FeedEntity>(feed, useCase: _useCaseModule.like);

  @injectable
  LikeCubit<CommentEntity> likeComment(CommentEntity comment) =>
      LikeCubit<CommentEntity>(comment, useCase: _useCaseModule.like);

  /// etc
  @lazySingleton
  ImageToTextBloc get image2Text => ImageToTextBloc();
}
