import 'package:injectable/injectable.dart';
import 'package:travel/presentation/bloc/comment/display/display_comment.bloc.dart';
import 'package:travel/presentation/bloc/comment/edit/edit_comment.bloc.dart';

import '../../domain/entity/meeting/meeting.dart';
import '../../domain/usecase/usecase_module.dart';
import 'auth/authentication.bloc.dart';
import 'diary/display/display_diary.bloc.dart';
import 'diary/edit/edit_diary.bloc.dart';
import 'image_to_text/image_to_text.bloc.dart';
import 'meeting/create/create_meeting.cubit.dart';
import 'meeting/display/display_meeting.bloc.dart';
import 'registration/display/display_registration.bloc.dart';
import 'registration/edit/edit_registration.bloc.dart';

@lazySingleton
class BlocModule {
  final UseCaseModule _useCaseModule;

  BlocModule(this._useCaseModule);

  @lazySingleton
  AuthenticationBloc get auth => AuthenticationBloc(
      authUseCase: _useCaseModule.auth, accountUseCase: _useCaseModule.account);

  @injectable
  EditDiaryBloc editDiary(String id) =>
      EditDiaryBloc(id: id, useCase: _useCaseModule.diary);

  @lazySingleton
  DisplayDiaryBloc get displayDiary => DisplayDiaryBloc(_useCaseModule.diary);

  @lazySingleton
  ImageToTextBloc get image2Text => ImageToTextBloc();

  @lazySingleton
  CreateMeetingCubit get createMeeting =>
      CreateMeetingCubit(_useCaseModule.meeting);

  @lazySingleton
  DisplayMeetingBloc get displayMeeting =>
      DisplayMeetingBloc(_useCaseModule.meeting);

  @injectable
  DisplayRegistrationBloc displayRegistration(MeetingEntity meeting) =>
      DisplayRegistrationBloc(meeting, useCase: _useCaseModule.registration);

  @injectable
  EditRegistrationBloc editRegistration(MeetingEntity meeting) =>
      EditRegistrationBloc(meeting, useCase: _useCaseModule.registration);

  @injectable
  DisplayCommentBloc<MeetingEntity> displayMeetingComment(
          MeetingEntity meeting) =>
      DisplayCommentBloc<MeetingEntity>(meeting,
          useCase: _useCaseModule.comment);

  @injectable
  EditCommentBloc<MeetingEntity> editMeetingComment(MeetingEntity meeting) =>
      EditCommentBloc<MeetingEntity>(meeting, useCase: _useCaseModule.comment);
}
