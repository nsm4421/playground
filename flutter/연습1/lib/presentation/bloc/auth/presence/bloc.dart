import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/domain/entity/auth/presence.dart';

import '../../../../core/abstract/abstract.dart';
import '../../../../core/constant/constant.dart';
import '../../../../domain/usecase/auth/usecase.dart';

part 'state.dart';

part 'event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>
    with CustomLogger {
  final AuthUseCase _useCase;

  late Stream<PresenceEntity?> _authStateStream;

  Stream<PresenceEntity?> get authStateStream => _authStateStream;

  AuthenticationBloc(this._useCase) : super(AuthenticationState()) {
    _authStateStream = _useCase.authStateStream;
    on<UpdateCurrentUserEvent>(_onUpdate);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onUpdate(
      UpdateCurrentUserEvent event, Emitter<AuthenticationState> emit) async {
    final currentUser = _useCase.currentUser;
    logger.t('current user updated id:${currentUser?.id}');
    emit(state.copyWith(currentUser: currentUser));
  }

  Future<void> _onSignOut(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    try {
      await _useCase.signOut.call().then((res) => res.fold(
          (l) => emit(state.copyWith(
              status: Status.error, currentUser: null, message: l.message)),
          (r) =>
              emit(state.copyWith(status: Status.success, currentUser: null))));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          currentUser: null,
          message: 'unknown error occurs'));
    }
  }
}
