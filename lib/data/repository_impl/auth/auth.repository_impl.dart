import 'package:injectable/injectable.dart';
import 'package:my_app/data/data_source/auth/auth.api.dart';
import 'package:my_app/domain/repository/auth/auth.repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthApi _authApi;

  AuthRepositoryImpl({required AuthApi authApi}) : _authApi = authApi;
}