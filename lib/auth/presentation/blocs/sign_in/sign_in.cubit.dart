import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/usecase/usecase.dart';

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
    } on AuthException catch (error) {
      log(error.message);
      switch (error.code) {
        case 'invalid_email':
        case 'invalid_password':
          emit(state.copyWith(
              status: SignInStatus.invalidParameter,
              errorMessage: '이메일이나 비밀번호를 다시 확인해주세요'));
        case 'user_not_found':
          emit(state.copyWith(
              status: SignInStatus.userNotFound,
              errorMessage: '존재하지 않는 유저명입니다'));
        case 'wrong_password':
          emit(state.copyWith(
              status: SignInStatus.wrongPassword,
              errorMessage: '비밀번호를 다시 확인해주세요'));
        default:
          emit(state.copyWith(
              status: SignInStatus.error, errorMessage: '로그인에 실패하였습니다'));
      }
    } catch (error) {
      log(error.toString());
      emit(SignInState(
          status: SignInStatus.error, errorMessage: '알 수 없는 이유로 로그인에 실패하였습니다'));
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
