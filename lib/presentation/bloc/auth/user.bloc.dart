import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/config/dependency_injection.dart';
import 'package:my_app/core/response/error_response.dart';
import 'package:my_app/domain/repository/auth/auth.repository.dart';
import 'package:my_app/domain/usecase/auth/edit_user_metadata.usecase.dart';
import 'package:my_app/domain/usecase/auth/sign_in_wigh_email_and_password.usecase.dart';
import 'package:my_app/domain/usecase/auth/sign_out.usecase.dart';
import 'package:my_app/domain/usecase/auth/sign_up_wigh_email_and_password.usecase.dart';
import '../../../core/enums/status.enum.dart';
import '../../../core/response/result.dart';
import '../../../domain/model/auth/user.model.dart';
import '../../../domain/usecase/auth/auth.usecase.dart';
import 'user.event.dart';
import 'user.state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthUseCase _authUseCase;

  UserBloc(this._authUseCase) : super(const UserState()) {
    on<UpdateUserState>(_onUpdateUserState);
    on<SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
    on<SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);
    on<SignOut>(_onSignOut);
    on<EditUserMetaData>(_onEditUserMetaData);
  }

  Future<void> _onUpdateUserState(
    UpdateUserState event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final user = getIt<AuthRepository>().getCurrentUer();

      emit(state.copyWith(
          authStatus: user == null
              ? AuthStatus.unAuthenticated
              : AuthStatus.authenticated,
          user: UserModel.fromUser(user),
          status: Status.success));
    } catch (err) {
      debugPrint(err.toString());
      emit(state.copyWith(
          status: Status.error, error: ErrorResponse.fromError(err)));
    }
  }

  Future<void> _onSignUpWithEmailAndPassword(
    SignUpWithEmailAndPassword event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final response = await _authUseCase.execute<Result<String>>(
          useCase: SignUpWithEmailAndPasswordUseCase(
              email: event.email, password: event.password));
      response.when(success: (String email) {
        emit(state.copyWith(status: Status.success));
      }, failure: (_) {
        emit(state.copyWith(status: Status.error));
      });
    } catch (err) {
      debugPrint(err.toString());
      emit(state.copyWith(
          status: Status.error, error: ErrorResponse.fromError(err)));
    }
  }

  Future<void> _onSignInWithEmailAndPassword(
      SignInWithEmailAndPassword event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final response = await _authUseCase.execute<Result<String>>(
          useCase: SignInWithEmailAndPasswordUseCase(
              email: event.email, password: event.password));
      response.when(success: (String email) {
        emit(state.copyWith(
            status: Status.success, authStatus: AuthStatus.authenticated));
      }, failure: (_) {
        emit(state.copyWith(status: Status.error));
      });
    } catch (err) {
      debugPrint(err.toString());
      emit(state.copyWith(
          status: Status.error, error: ErrorResponse.fromError(err)));
    }
  }

  Future<void> _onSignOut(SignOut event, Emitter<UserState> emit) async {
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

  Future<void> _onEditUserMetaData(
      EditUserMetaData event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final response = await _authUseCase.execute<Result<void>>(
          useCase: EditUserMetaDataUseCase(event.metaData));
      response.when(success: (_) {
        emit(state.copyWith(
            status: Status.success,
            user: state.user?.copyWith(metaData: event.metaData)));
      }, failure: (_) {
        emit(state.copyWith(
            status: Status.error,
            error: const ErrorResponse(
                code: 500,
                description: 'server error',
                message: 'fail to update meta data')));
      });
    } catch (err) {
      debugPrint(err.toString());
      emit(state.copyWith(
          status: Status.error, error: ErrorResponse.fromError(err)));
    }
  }
}
