import 'package:supabase_flutter/supabase_flutter.dart';

import '../base/auth.api.dart';

class RemoteAuthApi extends AuthApi {
  final GoTrueClient _auth;

  RemoteAuthApi(this._auth);

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Stream<User?> get authStream =>
      _auth.onAuthStateChange.map((event) => event.session?.user);

  @override
  Future<AuthResponse> signInWithEmailAndPassword(
          {required String email, required String password}) async =>
      await _auth.signInWithPassword(email: email, password: password);

  @override
  Future<AuthResponse> signUpWithEmailAndPassword(
          {required String email, required String password}) async =>
      await _auth.signUp(email: email, password: password);

  @override
  Future<void> signOut() async => await _auth.signOut();

  @override
  Future<void> updateUserMetaData(Map<String, String> data) async =>
      await _auth.updateUser(UserAttributes(data: data));
}
