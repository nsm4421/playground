part of 'cubit.dart';

class SignInState extends BaseState {
  final String email;
  final String password;

  SignInState(
      {super.status, super.message, this.email = '', this.password = ''});

  @override
  SignInState copyWith(
      {Status? status, String? message, String? email, String? password}) {
    return SignInState(
        status: status ?? this.status,
        message: message ?? this.message,
        email: email ?? this.email,
        password: password ?? this.password);
  }
}
