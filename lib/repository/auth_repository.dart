import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  Future<UserCredential> signUpWithGoogle() async => await GoogleSignIn()
      .signIn()
      .then((googleUser) async => await googleUser?.authentication)
      .then((auth) => GoogleAuthProvider.credential(
          accessToken: auth?.accessToken, idToken: auth?.idToken))
      .then((credential) async =>
          await FirebaseAuth.instance.signInWithCredential(credential));

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async =>
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<UserCredential> loginWithEmailAndPassword(
          String email, String password) async =>
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<void> saveUserInDB(UserCredential credential) async {
      if (credential.user == null) throw Exception('Credential has no info...');
      await FirebaseFirestore.instance.collection('users').add({
        "uid":credential.user?.uid,
        "email":credential.user?.email
      });
  }

}
