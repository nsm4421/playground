part of '../bloc.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthUseCase _authUseCase;

  LoginCubit(this._authUseCase) : super(LoginState());

  reset() => emit(LoginState(status: LoginStatus.init, errorMessage: null));

  signInWithEmailAndPassword(String email, String password) async {
    try {
      emit(LoginState(status: LoginStatus.loading));
      await _authUseCase.signInWithEmailAndPassword.call(email, password);
      emit(LoginState(status: LoginStatus.success, errorMessage: null));
    } catch (error) {
      log(error.toString());
      emit(LoginState(status: LoginStatus.error, errorMessage: '로그인에 실패하였습니다'));
    }
  }

  signInWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.loading));
    // TODO : 구글 로그인
    emit(LoginState(status: LoginStatus.success, errorMessage: null));
  }

  signInWithGithub() async {
    emit(state.copyWith(status: LoginStatus.loading));
    // TODO : 깃허브 로그인
    emit(LoginState(status: LoginStatus.success, errorMessage: null));
  }
}
