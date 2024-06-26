import 'package:my_app/core/response/response_wrapper.dart';
import 'package:my_app/domain/repository/base.repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository extends Repository {
  User? get currentUser;

  String? get currentUid;

  Stream<User?> get authStream;

  Future<void> signOut();

  Future<ResponseWrapper<void>> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<ResponseWrapper<void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
