import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../repository/auth/auth.repository.dart';

@lazySingleton
class GetAuthStateUseCase {
  final AuthRepository _repository;

  GetAuthStateUseCase(this._repository);

  Stream<AuthState> call() {
    return _repository.authState;
  }
}
