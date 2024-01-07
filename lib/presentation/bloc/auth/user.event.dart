abstract class UserEvent {
  const UserEvent();
}

class InitialAuthCheck extends UserEvent {}


class SignUpWithEmailAndPassword extends UserEvent {
  final String email;
  final String password;

  SignUpWithEmailAndPassword({required this.email, required this.password});
}

class SignInWithEmailAndPassword extends UserEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword({required this.email, required this.password});
}