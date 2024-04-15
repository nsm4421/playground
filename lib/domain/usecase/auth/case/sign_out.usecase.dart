import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.constant.dart';
import '../../../repository/auth/auth.repository.dart';

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    return await _repository.signOut();
  }
}
