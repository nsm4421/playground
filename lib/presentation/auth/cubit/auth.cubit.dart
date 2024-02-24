import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/core/constant/user.constant.dart';
import 'package:hot_place/presentation/auth/cubit/auth.state.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../domain/usecase/credential/get_current_uid.usecase.dart';
import '../../../domain/usecase/credential/get_current_user_stream.usecse.dart';
import '../../../domain/usecase/credential/is_authenticated.usecase.dart';
import '../../../domain/usecase/credential/sign_out.usecase.dart';


@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      {required this.getCurrentUidUseCase,
      required this.isAuthenticatedUseCase,
      required this.getCurrentUserStreamUseCase,
      required this.signOutUseCase})
      : super(const AuthState());

  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsAuthenticatedUseCase isAuthenticatedUseCase;
  final GetCurrentUserStreamUseCase getCurrentUserStreamUseCase;
  final SignOutUseCase signOutUseCase;
  final _logger = Logger();

  Stream<User?> get currentUserStream => getCurrentUserStreamUseCase();

  startApp() async {
    try {
      emit(state.copyWith(
          status: isAuthenticatedUseCase()
              ? AuthStatus.authenticated
              : AuthStatus.unAuthenticated));
      _logger.d("app started");
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: AuthStatus.unAuthenticated));
    }
  }

  logout() async {
    try {
      await signOutUseCase();
      _logger.d("log out");
    } catch (err) {
      _logger.e(err);
    } finally {
      emit(state.copyWith(status: AuthStatus.unAuthenticated, uid: null));
    }
  }
}
