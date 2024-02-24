import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/data/data_source/user/credential.data_source.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RemoteCredentialDataSource extends CredentialDataSource {
  final FirebaseAuth _auth;

  RemoteCredentialDataSource({required FirebaseAuth auth}) : _auth = auth;

  @override
  String? get currentUid => _auth.currentUser?.uid;

  @override
  Stream<User?> get currentUserStream => _auth.authStateChanges();

  @override
  Future<void> signOut() async => await _auth.signOut();

  @override
  Future<UserCredential> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }
}
