import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_meeting.state.dart';

class CreateMeetingCubit extends Cubit<CreateMeetingState> {
  CreateMeetingCubit() : super(const CreateMeetingState());

  void updateState(CreateMeetingState newState) {
    emit(newState);
  }
}
