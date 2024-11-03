import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:travel/core/util/extension/extension.dart';

import '../../../../core/constant/constant.dart';

part 'state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState());

  final _logger = Logger();

  void init({Status? status = Status.initial, String? message = ''}) async {
    emit(state.copyWith(status: status, message: message));
    _logger.t('status:$status|message:$message');
  }

  void edit({String? email, String? password}) async {
    emit(state.copyWith(email: email, password: password));
    _logger.t('email:${state.email}|password:${state.password}');
  }

  Future<void> signIn() async {
    emit(state.copyWith(status: Status.loading));
    await Future.delayed(2.sec, () {});
    try {
      _logger.t('email:${state.email}|password:${state.password}');
      // TODO : 로그인 처리
      emit(state.copyWith(status: Status.success));
    } catch (error) {
      _logger.e(error);
      emit(state.copyWith(status: Status.error));
    }
  }
}
