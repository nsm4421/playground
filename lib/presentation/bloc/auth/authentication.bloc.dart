import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/domain/entity/auth/presence.dart';
import 'package:travel/domain/usecase/account/usecase.dart';

import '../../../core/constant/constant.dart';
import '../../../domain/usecase/auth/usecase.dart';

part 'authentication.state.dart';

part 'authentication.event.dart';

@lazySingleton
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthUseCase _authUseCase;
  final AccountUseCase _accountUseCase;

  AuthenticationBloc(
      {required AuthUseCase authUseCase,
      required AccountUseCase accountUseCase})
      : _authUseCase = authUseCase,
        _accountUseCase = accountUseCase,
        super(AuthenticationState()) {
    on<InitializeEvent>(_onInit);
    on<SignUpWithEmailAndPasswordEvent>(_onSignUp);
    on<SignInWithEmailAndPasswordEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
  }

  Stream<PresenceEntity?> get authStateStream =>
      _authUseCase.authStateStream.call();

  Future<bool> isUsernameDuplicated(String username) async =>
      await _accountUseCase.isUsernameDuplicated.call(username);

  Future<void> _onInit(
      InitializeEvent event, Emitter<AuthenticationState> emit) async {
    emit(state
        .copyWith(
            status: event.status ?? state.status,
            step: event.step ?? state.step,
            errorMessage: event.errorMessage ?? state.errorMessage)
        .copyWithCurrentUser(event.presence));
  }

  Future<void> _onSignUp(SignUpWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: Status.loading));
    await _authUseCase
        .signUp(
            email: event.email,
            password: event.password,
            username: event.username,
            profileImage: event.profileImage)
        .fold((l) {
      emit(state
          .copyWith(status: Status.error, errorMessage: l.message)
          .copyWithCurrentUser(null));
    }, (r) {
      emit(state
          .copyWith(status: Status.success, step: AuthenticationStep.authorized)
          .copyWithCurrentUser(r));
    });
  }

  Future<void> _onSignIn(SignInWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await _authUseCase
        .signIn(email: event.email, password: event.password)
        .then((res) => res.fold((l) {
              emit(state
                  .copyWith(status: Status.error, errorMessage: l.message)
                  .copyWithCurrentUser(null));
            }, (r) {
              emit(state
                  .copyWith(
                      status: Status.success,
                      step: AuthenticationStep.authorized)
                  .copyWithCurrentUser(r));
            }));
  }

  Future<void> _onSignOut(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: Status.loading));
    await _authUseCase.signOut().then((res) => res.fold((l) {
          emit(state.copyWith(
              status: Status.error,
              step: AuthenticationStep.signIn,
              errorMessage: l.message));
        }, (r) {
          emit(state
              .copyWith(status: Status.success, step: AuthenticationStep.signIn)
              .copyWithCurrentUser(null));
        }));
  }
}
