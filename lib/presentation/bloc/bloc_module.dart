import 'package:injectable/injectable.dart';
import 'package:travel/presentation/bloc/meeting/create/create_meeting.cubit.dart';

import '../../domain/usecase/usecase_module.dart';
import 'auth/authentication.bloc.dart';
import 'diary/display/display_diary.bloc.dart';
import 'diary/edit/edit_diary.bloc.dart';
import 'image_to_text/image_to_text.bloc.dart';
import 'meeting/display/display_meeting.bloc.dart';

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
}
