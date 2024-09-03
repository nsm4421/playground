part of '../../bloc.dart';

enum SignInStatus {
  init,
  loading,
  success,
  // errors
  invalidCredentials,
  userNotFound,
  networkError,
  error;
}

class SignInState {
  final SignInStatus status;
  final String? errorMessage;

  SignInState({this.status = SignInStatus.init, this.errorMessage});

  // 로그인 요청을 보낼 수 있는지 상태 여부
  bool get isReady => status == SignInStatus.init;

  SignInState copyWith({
    SignInStatus? status,
    String? errorMessage,
  }) {
    return SignInState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
