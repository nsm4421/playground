import 'package:injectable/injectable.dart';

import '../../domain/entity/comment/comment.dart';
import '../../domain/entity/diary/diary.dart';
import '../../domain/entity/meeting/meeting.dart';
import '../../domain/usecase/usecase_module.dart';
import 'auth/authentication.bloc.dart';
import 'bottom_nav/home_bottom_nav.cubit.dart';
import 'comment/display/display_comment.bloc.dart';
import 'comment/edit/edit_comment.bloc.dart';
import 'diary/display/display_diary.bloc.dart';
import 'diary/edit/edit_diary.bloc.dart';
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

  /// diary
  @injectable
  EditDiaryBloc editDiary(String id) =>
      EditDiaryBloc(id: id, useCase: _useCaseModule.diary);

  @lazySingleton
  DisplayDiaryBloc get displayDiary => DisplayDiaryBloc(_useCaseModule.diary);

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
  DisplayCommentBloc<DiaryEntity> displayDiaryComment(DiaryEntity diary) =>
      DisplayCommentBloc<DiaryEntity>(diary, useCase: _useCaseModule.comment);

  @injectable
  EditCommentBloc<DiaryEntity> editDiaryComment(DiaryEntity diary) =>
      EditCommentBloc<DiaryEntity>(diary, useCase: _useCaseModule.comment);

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
  LikeCubit<DiaryEntity> likeDiary(DiaryEntity diary) =>
      LikeCubit<DiaryEntity>(diary, useCase: _useCaseModule.like);

  @injectable
  LikeCubit<CommentEntity> likeComment(CommentEntity comment) =>
      LikeCubit<CommentEntity>(comment, useCase: _useCaseModule.like);

  /// etc
  @lazySingleton
  ImageToTextBloc get image2Text => ImageToTextBloc();
}
