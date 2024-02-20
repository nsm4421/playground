import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/features/app/constant/user.constant.dart';
import 'package:hot_place/features/user/presentation/bloc/auth/auth.state.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../domain/usecase/auth/get_current_uid.usecase.dart';
import '../../../domain/usecase/auth/is_authroized.usecase.dart';
import '../../../domain/usecase/auth/sign_out.usecase.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      {required this.getCurrentUidUseCase,
      required this.isAuthorizedUseCase,
      required this.signOutUseCase})
      : super(const AuthState());

  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsAuthorizedUseCase isAuthorizedUseCase;
  final SignOutUseCase signOutUseCase;
  final _logger = Logger();

  startApp() {
    try {
      final isAuthorized = isAuthorizedUseCase();
      if (isAuthorized) {
        emit(state.copyWith(
            status: AuthStatus.authenticated, uid: getCurrentUidUseCase()!));
      } else {
        emit(state.copyWith(status: AuthStatus.unAuthenticated, uid: null));
      }
      _logger.d("app started");
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: AuthStatus.unAuthenticated));
    }
  }

  login() {
    try {
      emit(state.copyWith(
          status: AuthStatus.authenticated, uid: getCurrentUidUseCase()!));
      _logger.d("log in");
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: AuthStatus.unAuthenticated));
    }
  }

  logout() async {
    try {
      await signOutUseCase();
      emit(state.copyWith(status: AuthStatus.unAuthenticated, uid: null));
      _logger.d("log out");
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: AuthStatus.unAuthenticated, uid: null));
    }
  }
}
