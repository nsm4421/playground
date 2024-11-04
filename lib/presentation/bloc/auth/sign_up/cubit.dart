import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/abstract/abstract.dart';
import '../../../../core/constant/constant.dart';
import '../../../../domain/usecase/usecase.dart';

part 'state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._useCase) : super(SignUpState()) {
    _formKey = GlobalKey<FormState>(debugLabel: 'sign-up-form-key');
  }

  final UseCaseModule _useCase;

  final _logger = Logger();
  late GlobalKey<FormState> _formKey;

  GlobalKey<FormState> get formKey => _formKey;

  void init({Status? status = Status.initial, String? message = ''}) async {
    emit(state.copyWith(status: status, message: message));
    _logger.t('status:$status|message:$message');
  }

  void selectProfileImage(File profileImage) {
    emit(state.copyWithProfileImage(profileImage));
  }

  void unSelectProfileImage() {
    emit(state.copyWithProfileImage(null));
  }

  void edit({String? email, String? password, String? username}) async {
    emit(state.copyWith(email: email, password: password, username: username));
    _logger.t(
        'email:${state.email}|password:${state.password}|username:${state.username}');
  }

  Future<void> signUp() async {
    try {
      final ok = _formKey.currentState?.validate();
      if (ok == null || !ok) {
        emit(state.copyWith(
            status: Status.error, message: 'form is not filled'));
      } else if (state.profileImage == null) {
        emit(state.copyWith(
            status: Status.error, message: 'profile image is not selected'));
      } else {
        emit(state.copyWith(status: Status.loading));
        _logger.t('email:${state.email}|password:${state.password}');
        // TODO : 회원가입 처리
        await _useCase
            .signUp(
                email: state.email,
                password: state.password,
                username: state.username,
                profileImage: state.profileImage!)
            .then((res) => res.fold(
                (l) => emit(
                    state.copyWith(status: Status.error, message: l.message)),
                (r) => emit(state.copyWith(status: Status.success))));
      }
    } catch (error) {
      _logger.e(error);
      emit(state.copyWith(status: Status.error));
    }
  }
}
