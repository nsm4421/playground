import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/core/exception/custom_exception.dart';

part 'auth.datasource.dart';

class LocalAuthDataSourceImpl implements LocalAuthDataSource {}

class RemoteAuthDataSourceImpl implements RemoteAuthDataSource {
  final FirebaseAuth _auth;
  final Logger _logger;
  final GoogleSignIn _googleSignIn;

  RemoteAuthDataSourceImpl(
      {required FirebaseAuth auth,
      required Logger logger,
      required GoogleSignIn googleSignIn})
      : _auth = auth,
        _logger = logger,
        _googleSignIn = googleSignIn;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Stream<User?> get authStream => _auth.authStateChanges();

  @override
  Future<User> signInWithGoogle() async {
    try {
      final credential = await _googleSignIn
          .signIn()
          .then((res) async => await res?.authentication)
          .then((auth) => GoogleAuthProvider.credential(
                accessToken: auth?.accessToken,
                idToken: auth?.idToken,
              ));
      return await _auth
          .signInWithCredential(credential)
          .then((res) => res.user!);
    } catch (error) {
      throw CustomException.from(error,
          logger: _logger, message: 'google sign in fail');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      throw CustomException.from(error,
          logger: _logger, message: 'sign out fail');
    }
  }
}
