part of '../bloc.dart';

enum LoginStatus {
  init,
  loading,
  success,
  // errors
  invalidCredentials,
  userNotFound,
  networkError,
  error;
}

class LoginState {
  final LoginStatus status;
  final String? errorMessage;

  LoginState({this.status = LoginStatus.init, this.errorMessage});

  // 로그인 요청을 보낼 수 있는지 상태 여부
  bool get isReady => status == LoginStatus.init;

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
