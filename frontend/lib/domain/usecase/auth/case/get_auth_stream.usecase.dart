import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../repository/auth/auth.repository.dart';

class GetAuthStreamUseCase {
  final AuthRepository _repository;

  GetAuthStreamUseCase(this._repository);

  Stream<AuthState> call() {
    return _repository.authStream;
  }
}
