import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/config/dependency_injection.dart';
import 'package:my_app/core/response/error_response.dart';
import 'package:my_app/domain/repository/auth/auth.repository.dart';
import 'package:my_app/domain/usecase/auth/sign_up_wigh_email_and_password.usecase.dart';
import '../../../core/enums/status.enum.dart';
import '../../../core/response/result.dart';
import '../../../domain/usecase/auth/auth.usecase.dart';
import 'user.event.dart';
import 'user.state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthUseCase _authUseCase;

  UserBloc(this._authUseCase) : super(const UserState()) {
    on<InitialAuthCheck>(_onInitialAuthCheck);
    on<SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
  }

  Future<void> _onInitialAuthCheck(
    InitialAuthCheck event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final user = getIt<AuthRepository>().getCurrentUer();
      emit(state.copyWith(
          authStatus: user == null
              ? AuthStatus.unAuthenticated
              : AuthStatus.authenticated,
          status: Status.success));
    } catch (err) {
      emit(state.copyWith(
          authStatus: AuthStatus.initial,
          status: Status.error,
          error: ErrorResponse.fromError(err)));
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
      emit(state.copyWith(
          status: Status.error, error: ErrorResponse.fromError(err)));
    }
  }

  Future<void> _onSignInWithEmailAndPassword(
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
      emit(state.copyWith(
          status: Status.error, error: ErrorResponse.fromError(err)));
    }
  }

}
