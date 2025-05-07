part of 'repository.dart';

abstract interface class AuthRepository {
  Stream<PresenceEntity?> get authStateStream;

  PresenceEntity? get currentUser;

  bool get isAuthorized;

  Future<Either<ErrorResponse, PresenceEntity?>> editProfile(
      {String? username, File? profileImage});

  Future<Either<ErrorResponse, PresenceEntity?>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required File profileImage});

  Future<Either<ErrorResponse, PresenceEntity?>> signInWithEmailAndPassword(
      String email, String password);

  Future<Either<ErrorResponse, void>> signOut();
}
