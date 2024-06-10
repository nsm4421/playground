part of 'package:my_app/data/repository_impl/user/auth.repository_impl.dart';

abstract interface class AuthRepository {
  User? get currentUser;

  Stream<User?> get authStream;

  Future<Either<Failure, User?>> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, User?>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, User?>> signInWithGoogle();

  Future<Either<Failure, void>> signOut();
}
