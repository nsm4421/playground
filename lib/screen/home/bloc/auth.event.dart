abstract class AuthEvent {
  const AuthEvent();
}

class InitAuthEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}