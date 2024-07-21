import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio/core/constant/response_wrapper.dart';
import 'package:portfolio/features/auth/data/datasource/auth.datasource_impl.dart';
import 'package:portfolio/features/auth/data/model/account.model.dart';
import 'package:portfolio/features/auth/domain/entity/account.entity.dart';
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
  Future<ResponseWrapper<User>> signUpWithEmailAndPassword(
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
  Future<ResponseWrapper<void>> signOut() async {
    try {
      await _dataSource.signOut();
      return ResponseWrapper.success(null);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('sign out fail');
    }
  }

  @override
  Future<ResponseWrapper<void>> insertAccount(AccountEntity entity) async {
    try {
      await _dataSource.insertAccount(AccountModel.fromEntity(entity));
      return ResponseWrapper.success(null);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('insert account fail');
    }
  }

  @override
  Future<ResponseWrapper<User>> updateMetaData(
      {String? nickname, String? profileImage}) async {
    try {
      final user = await _dataSource.updateMetaData(
          nickname: nickname, profileImage: profileImage);
      return user == null
          ? ResponseWrapper.error('update metadata fail')
          : ResponseWrapper.success(user);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('update metadata fail');
    }
  }

  @override
  Future<ResponseWrapper<void>> updateAccount(
      {required String uid, String? nickname, String? profileImage}) async {
    try {
      await _dataSource.updateAccount(
          uid: uid, nickname: nickname, profileImage: profileImage);
      return ResponseWrapper.success(null);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('update account fail');
    }
  }
}
