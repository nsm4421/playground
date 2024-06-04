part of 'package:my_app/data/repository_impl/auth/auth.repository_impl.dart';

abstract interface class AuthRepository {
  User? get currentUser;

  Stream<User?> get authStream;

  Future<Either<Failure, User>> signInWithGoogle();

  Future<Either<Failure, void>> signOut();
}
