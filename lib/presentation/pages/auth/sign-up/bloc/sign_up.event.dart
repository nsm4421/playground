import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.state.dart';

abstract class SignUpEvent {
  const SignUpEvent();
}

class GoogleSignUpEvent extends SignUpEvent {
  GoogleSignUpEvent();
}

class UpdateUserStateEvent extends SignUpEvent {
  final SignUpState state;

  UpdateUserStateEvent(this.state);
}
