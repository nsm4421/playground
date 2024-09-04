part of '../../bloc.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final AuthUseCase _authUseCase;

  SignUpCubit(this._authUseCase) : super(SignUpState());

  reset() => emit(SignUpState(status: SignUpStatus.init, errorMessage: null));

  checkUsername(String username) async {
    try {
      await _authUseCase.checkUsername.call(username).then((ok) {
        if (!ok) {
          emit(state.copyWith(status: SignUpStatus.dupliacatedUsername));
        }
      });
    } catch (error) {
      log(error.toString());
      emit(SignUpState(status: SignUpStatus.error, errorMessage: '중복된 유저명입니다'));
    }
  }

  signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required File profileImage,
  }) async {
    try {
      log('회원가입 요청 email:$email');
      emit(SignUpState(status: SignUpStatus.loading));
      await _authUseCase.signUpWithEmailAndPassword.call(
          email: email,
          password: password,
          username: username,
          profileImage: profileImage);
      emit(SignUpState(status: SignUpStatus.success, errorMessage: null));
    } catch (error) {
      log(error.toString());
      emit(SignUpState(
          status: SignUpStatus.error, errorMessage: '회원가입에 실패하였습니다'));
    }
  }
}
