import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio/core/response/response_wrapper.dart';
import 'package:portfolio/features/auth/data/datasource/auth.datasource_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'package:portfolio/features/auth/domain/repository/auth.repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;
  final Logger _logger = Logger();

  AuthRepositoryImpl(this._dataSource);

  @override
  User? get currentUser => _dataSource.currentUser;

  @override
  Stream<AuthState> get authStream => _dataSource.authStream;

  @override
  Future<ResponseWrapper<User>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final user =
          await _dataSource.signUpWithEmailAndPassword(email, password);
      return user == null
          ? ResponseWrapper.error('auth response is not valid')
          : ResponseWrapper.success(user);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('sign up fail');
    }
  }

  @override
  Future<ResponseWrapper<User>> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final user =
          await _dataSource.signInWithEmailAndPassword(email, password);
      return user == null
          ? ResponseWrapper.error('auth response is not valid')
          : ResponseWrapper.success(user);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('sign in fail');
    }
  }

  @override
  Future<ResponseWrapper<void>> signOut() async {
    try {
      await _dataSource.signOut();
      return ResponseWrapper.success(null);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('sign out fail');
    }
  }
}
