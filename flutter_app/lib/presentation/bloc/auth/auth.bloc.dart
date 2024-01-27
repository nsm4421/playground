import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/config/dependency_injection.dart';
import 'package:my_app/core/response/error_response.dart';
import 'package:my_app/domain/repository/auth/auth.repository.dart';
import 'package:my_app/domain/usecase/auth/sign_in_wigh_email_and_password.usecase.dart';
import 'package:my_app/domain/usecase/auth/sign_out.usecase.dart';
import 'package:my_app/domain/usecase/auth/sign_up_wigh_email_and_password.usecase.dart';
import '../../../core/enums/status.enum.dart';
import '../../../core/response/result.dart';
import '../../../domain/usecase/auth/auth.usecase.dart';
import 'auth.event.dart';
import 'auth.state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(const AuthState()) {
    on<UpdateAuthState>(_onUpdateUserState);
    on<SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
    on<SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);
    on<SignOut>(_onSignOut);
  }

  /// 유저 상태 업데이트
  Future<void> _onUpdateUserState(
    UpdateAuthState event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));

      // 전달받은 인증정보가 없는 경우, API로 부터 인증정보 가져오기
      final user = event.user ?? getIt<AuthRepository>().currentUser;
      emit(state.copyWith(
          // 인증상태
          authStatus: user == null
              ? AuthStatus.unAuthenticated
              : AuthStatus.authenticated,
          user: user,
          status: Status.success));
    } catch (err) {
      debugPrint(err.toString());
      emit(state.copyWith(
          status: Status.error, error: ErrorResponse.fromError(err)));
    }
  }

  /// 회원가입
  Future<void> _onSignUpWithEmailAndPassword(
    SignUpWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final response = await _authUseCase.execute<Result<String>>(
          useCase: SignUpWithEmailAndPasswordUseCase(
              email: event.email, password: event.password));
      response.when(success: (String email) {
        emit(state.copyWith(status: Status.success));
      }, failure: (err) {
        emit(state.copyWith(status: Status.error, error: err));
      });
    } catch (err) {
      debugPrint(err.toString());
      emit(state.copyWith(
          status: Status.error, error: ErrorResponse.fromError(err)));
    }
  }

  /// 로그인
  Future<void> _onSignInWithEmailAndPassword(
      SignInWithEmailAndPassword event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final response = await _authUseCase.execute<Result<String>>(
          useCase: SignInWithEmailAndPasswordUseCase(
              email: event.email, password: event.password));
      response.when(success: (String _) {
        emit(state.copyWith(
            status: Status.success, authStatus: AuthStatus.authenticated));
      }, failure: (err) {
        emit(state.copyWith(status: Status.error, error: err));
      });
    } catch (err) {
      debugPrint(err.toString());
      emit(state.copyWith(
          status: Status.error, error: ErrorResponse.fromError(err)));
    }
  }

  /// 로그아웃
  Future<void> _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    try {
      await _authUseCase.execute<void>(useCase: SignOutUseCase());
      emit(state.copyWith(
          status: Status.success, authStatus: AuthStatus.unAuthenticated));
    } catch (err) {
      debugPrint(err.toString());
      emit(state.copyWith(
          status: Status.error, error: ErrorResponse.fromError(err)));
    }
  }
}
