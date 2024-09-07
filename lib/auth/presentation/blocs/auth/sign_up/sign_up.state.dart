part of 'sign_up.cubit.dart';

enum SignUpStatus {
  init,
  loading,
  success,
  // errors
  weakPassword,
  dupliacatedUsername,
  networkError,
  error;
}

class SignUpState {
  final SignUpStatus status;
  final String? errorMessage;

  SignUpState({this.status = SignUpStatus.init, this.errorMessage});

  // 회원가입 요청을 보낼 수 있는지 상태 여부
  bool get isReady => status == SignUpStatus.init;

  SignUpState copyWith({
    SignUpStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
