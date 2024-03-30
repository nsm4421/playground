import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../repository/auth/auth.repository.dart';

@singleton
class GetAuthStreamUseCase {
  final AuthRepository _repository;

  GetAuthStreamUseCase(this._repository);

  Stream<AuthState> call() {
    return _repository.authStream;
  }
}
