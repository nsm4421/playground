import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/logger/logger.dart';

import '../../../../core/abstract/abstract.dart';
import '../../../../core/constant/constant.dart';
import '../../../../domain/usecase/auth/usecase.dart';

part 'state.dart';

class SignInCubit extends Cubit<SignInState> with CustomLogger {
  SignInCubit(this._useCase) : super(SignInState()) {
    _formKey = GlobalKey<FormState>(debugLabel: 'sign-in-form-key');
  }

  final AuthUseCase _useCase;
  late GlobalKey<FormState> _formKey;

  GlobalKey<FormState> get formKey => _formKey;

  bool get ok {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    return (ok != null) && ok;
  }

  void init({Status? status = Status.initial, String? message = ''}) async {
    emit(state.copyWith(status: status, message: message));
    logger.t('status:$status|message:$message');
  }

  void edit({String? email, String? password}) async {
    emit(state.copyWith(email: email, password: password));
    logger.t('email:${state.email}|password:${state.password}');
  }

  Future<void> signIn() async {
    emit(state.copyWith(status: Status.loading));
    try {
      await _useCase
          .signIn(email: state.email, password: state.password)
          .then((res) => res.fold(
              (l) => emit(state.copyWith(
              status: Status.error, message: 'sign in fails')),
              (r) => emit(state.copyWith(status: Status.success))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error));
    }
  }
}
