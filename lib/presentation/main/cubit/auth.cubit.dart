import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/core/constant/user.constant.dart';
import 'package:hot_place/domain/usecase/credential/google_sign_in.usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../domain/usecase/credential/get_current_uid.usecase.dart';
import '../../../domain/usecase/credential/get_current_user_stream.usecse.dart';
import '../../../domain/usecase/credential/is_authenticated.usecase.dart';
import '../../../domain/usecase/credential/sign_out.usecase.dart';

@singleton
class AuthCubit extends Cubit<AuthStatus> {
  AuthCubit(this._googleSignUpUseCase,
      {required GetCurrentUidUseCase getCurrentUidUseCase,
      required IsAuthenticatedUseCase isAuthenticatedUseCase,
      required GetCurrentUserStreamUseCase getCurrentUserStreamUseCase,
      required SignOutUseCase signOutUseCase})
      : _getCurrentUidUseCase = getCurrentUidUseCase,
        _isAuthenticatedUseCase = isAuthenticatedUseCase,
        _getCurrentUserStreamUseCase = getCurrentUserStreamUseCase,
        _signOutUseCase = signOutUseCase,
        super(AuthStatus.unAuthenticated);

  final GetCurrentUidUseCase _getCurrentUidUseCase;
  final IsAuthenticatedUseCase _isAuthenticatedUseCase;
  final GetCurrentUserStreamUseCase _getCurrentUserStreamUseCase;
  final SignOutUseCase _signOutUseCase;
  final GoogleSignInUseCase _googleSignUpUseCase;
  final _logger = Logger();

  Stream<User?> get currentUserStream => _getCurrentUserStreamUseCase();

  updateAuthStatus() async {
    try {
      emit(_isAuthenticatedUseCase()
          ? AuthStatus.authenticated
          : AuthStatus.unAuthenticated);
    } catch (err) {
      _logger.e(err);
      emit(AuthStatus.unAuthenticated);
    }
  }

  signOut() async {
    try {
      await _signOutUseCase();
      _logger.d("log out");
    } catch (err) {
      _logger.e(err);
    } finally {
      emit(AuthStatus.unAuthenticated);
    }
  }

  googleSignIn() async {
    await _googleSignUpUseCase();
  }
}
