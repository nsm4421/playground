part of '../../bloc.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final AuthUseCase _authUseCase;

  SignUpCubit(this._authUseCase) : super(SignUpState());

  reset() => emit(SignUpState(status: SignUpStatus.init, errorMessage: null));

  signUpWithEmailAndPassword(String email, String password) async {
    try {
      emit(SignUpState(status: SignUpStatus.loading));
      await _authUseCase.signUpWithEmailAndPassword.call(email, password);
      emit(SignUpState(status: SignUpStatus.success, errorMessage: null));
    } catch (error) {
      log(error.toString());
      emit(SignUpState(
          status: SignUpStatus.error, errorMessage: '회원가입에 실패하였습니다'));
    }
  }
}
