import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import '../../../core/exception/custom_exception.dart';
import '../../datasource/auth/auth.datasource_impl.dart';

part 'package:my_app/domain/repository/auth/auth.repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthDataSource _remoteDataSource;

  AuthRepositoryImpl({required RemoteAuthDataSource remoteAuthDataSource})
      : _remoteDataSource = remoteAuthDataSource;

  @override
  User? get currentUser => _remoteDataSource.currentUser;

  @override
  Stream<User?> get authStream => _remoteDataSource.authStream;

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      return await _remoteDataSource
          .signInWithGoogle()
          .then((user) => right(user));
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      return await _remoteDataSource.signOut().then((_) => right(null));
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
