import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/usecase/usecase.dart';

part 'sign_in.state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final AuthUseCase _authUseCase;

  SignInCubit(this._authUseCase) : super(SignInState());

  reset() => emit(SignInState(status: SignInStatus.init, errorMessage: null));

  signInWithEmailAndPassword(String email, String password) async {
    try {
      emit(SignInState(status: SignInStatus.loading));
      await _authUseCase.signInWithEmailAndPassword.call(email, password);
      emit(SignInState(status: SignInStatus.success, errorMessage: null));
    } catch (error) {
      log(error.toString());
      emit(SignInState(
          status: SignInStatus.error, errorMessage: '로그인에 실패하였습니다'));
    }
  }

  signInWithGoogle() async {
    emit(state.copyWith(status: SignInStatus.loading));
    // TODO : 구글 로그인
    emit(SignInState(status: SignInStatus.success, errorMessage: null));
  }

  signInWithGithub() async {
    emit(state.copyWith(status: SignInStatus.loading));
    // TODO : 깃허브 로그인
    emit(SignInState(status: SignInStatus.success, errorMessage: null));
  }
}
