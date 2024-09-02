import 'package:flutter_app/auth/data/datasource/datasource_impl.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _dataSource.signUpWithEmailAndPassword(email, password);
  }
}
