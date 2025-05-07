import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/domain/entity/auth/account.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constant/status.dart';
import '../../../domain/usecase/auth/auth.usecase_module.dart';
import 'auth.state.dart';

part 'auth.event.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthenticationState> {
  final AuthUseCase _useCase;

  AuthBloc({required AuthUseCase useCase})
      : _useCase = useCase,
        super(const AuthenticationState()) {
    on<InitAuthEvent>(_onInit);
    on<SignUpWithEmailAndPasswordEvent>(_onSignUp);
    on<SignInWithEmailAndPasswordEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
    on<EditProfileEvent>(_onEdit);
  }

  User? get currentUser => _useCase.currentUser.call();

  AccountEntity? get account {
    final user = currentUser;
    return user == null ? null : AccountEntity.fromUser(user);
  }

  Stream<AuthState> get authStream => _useCase.authStream.call();

  Future<bool> isNicknameDuplicated(String nickname) async {
    return await _useCase.checkNickname(nickname).then((res) => res.ok);
  }

  Future<void> _onInit(
      InitAuthEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: event.status ?? Status.initial));
  }

  Future<void> _onSignUp(SignUpWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final res = await _useCase.signUpWithEmailAndPassword(
        profileImage: event.profileImage,
        email: event.email,
        password: event.password);
    if (res.ok && res.data != null) {
      emit(state.copyWith(status: Status.success, user: res.data!));
    } else {
      emit(state.copyWith(
          status: Status.error, user: null, message: res.message));
    }
  }

  Future<void> _onSignIn(SignInWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final res =
        await _useCase.signInWithEmailAndPassword(event.email, event.password);
    if (res.ok && res.data != null) {
      emit(state.copyWith(status: Status.success, user: res.data!));
    } else {
      emit(state.copyWith(
          status: Status.error, user: null, message: res.message));
    }
  }

  Future<void> _onSignOut(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final res = await _useCase.signOut();
    if (res.ok) {
      emit(state.copyWith(status: Status.success, user: null));
    } else {
      emit(state.copyWith(status: Status.error, message: res.message));
    }
  }

  Future<void> _onEdit(
      EditProfileEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final res = await _useCase.editProfile(
        uid: _useCase.currentUser.call()!.id,
        nickname: event.nickname,
        profileImage: event.profileImage);
    if (res.ok) {
      emit(state.copyWith(status: Status.success, user: null));
    } else {
      emit(state.copyWith(status: Status.error, message: res.message));
    }
  }
}
