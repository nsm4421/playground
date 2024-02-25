import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/main/bloc/auth.event.dart';
import 'package:hot_place/presentation/main/bloc/auth.state.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../core/constant/user.constant.dart';
import '../../../domain/usecase/credential/get_current_user_stream.usecse.dart';
import '../../../domain/usecase/credential/google_sign_in.usecase.dart';
import '../../../domain/usecase/credential/is_authenticated.usecase.dart';
import '../../../domain/usecase/credential/sign_out.usecase.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required GoogleSignInUseCase googleSignUpUseCase,
      required IsAuthenticatedUseCase isAuthenticatedUseCase,
      required GetCurrentUserStreamUseCase getCurrentUserStreamUseCase,
      required SignOutUseCase signOutUseCase})
      : _googleSignUpUseCase = googleSignUpUseCase,
        _isAuthenticatedUseCase = isAuthenticatedUseCase,
        _getCurrentUserStreamUseCase = getCurrentUserStreamUseCase,
        _signOutUseCase = signOutUseCase,
        super(const AuthState()) {
    on<UpdateAuthEvent>(_onUpdateAuth);
    on<SignOutEvent>(_onSignOut);
    on<GoogleSignInEvent>(_googleSignIn);
  }

  final IsAuthenticatedUseCase _isAuthenticatedUseCase;
  final GetCurrentUserStreamUseCase _getCurrentUserStreamUseCase;
  final SignOutUseCase _signOutUseCase;
  final GoogleSignInUseCase _googleSignUpUseCase;
  final _logger = Logger();

  Stream<User?> get currentUserStream => _getCurrentUserStreamUseCase();

  Future<void> _onUpdateAuth(
    UpdateAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(
          status: _isAuthenticatedUseCase()
              ? AuthStatus.authenticated
              : AuthStatus.unAuthenticated));
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: AuthStatus.unAuthenticated));
    }
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _signOutUseCase();
      _logger.d("log out");
    } catch (err) {
      _logger.e(err);
    } finally {
      emit(state.copyWith(
          status: AuthStatus.unAuthenticated, currentUser: null));
    }
  }

  Future<void> _googleSignIn(
    GoogleSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await _googleSignUpUseCase();
      emit(state.copyWith(status: AuthStatus.authenticated, currentUser: user));
      _logger.d("log out");
    } catch (err) {
      _logger.e(err);
    } finally {
      emit(state.copyWith(status: AuthStatus.unAuthenticated));
    }
  }
}
