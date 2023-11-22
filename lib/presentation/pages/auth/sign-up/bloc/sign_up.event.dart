import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.state.dart';

abstract class SignUpEvent {
  const SignUpEvent();
}

class GoogleSignUpEvent extends SignUpEvent {
  GoogleSignUpEvent();
}

class UpdateOnBoardStateEvent extends SignUpEvent {
  final SignUpState state;

  UpdateOnBoardStateEvent(this.state);
}

class SubmitUserInfoEvent extends SignUpEvent {
  SubmitUserInfoEvent();
}
