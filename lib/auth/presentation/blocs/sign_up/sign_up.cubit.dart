import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/usecase/usecase.dart';

part 'sign_up.state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final AuthUseCase _authUseCase;

  SignUpCubit(this._authUseCase) : super(SignUpState());

  reset() => emit(SignUpState(status: SignUpStatus.init, errorMessage: null));

  checkUsername(String username) async {
    await _authUseCase.checkUsername.call(username).then((ok) {
      if (!ok) {
        emit(state.copyWith(
            status: SignUpStatus.dupliacatedUsername,
            errorMessage: '중복된 유저명입니다'));
      }
    });
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
    } on AuthException catch (error) {
      log(error.toString());
      switch (error.code) {
        case 'invalid_email':
        case 'invalid_password':
          emit(SignUpState(
              status: SignUpStatus.invalidParameter,
              errorMessage: '이메일이나 비밀번호가 유효하지 않습니다'));
        case 'weak_password':
          emit(SignUpState(
              status: SignUpStatus.weakPassword,
              errorMessage: '비밀번호를 좀 더 어렵게 지어주세요'));
        case 'email_already_exists':
          emit(SignUpState(
              status: SignUpStatus.alreadyExistEmail,
              errorMessage: '이미 회원가입된 이메일입니다'));
        default:
          emit(SignUpState(
              status: SignUpStatus.error, errorMessage: '회원가입에 실패하였습니다'));
      }
    } on PostgrestException catch (error) {
      log(error.toString());
      emit(SignUpState(
          status: SignUpStatus.dupliacatedUsername,
          errorMessage: '이미 존재하는 유저명입니다'));
    } catch (error) {
      log(error.toString());
      emit(SignUpState(
          status: SignUpStatus.error, errorMessage: '알수없는 오류로 회원가입에 실패하였습니다'));
    }
  }
}
