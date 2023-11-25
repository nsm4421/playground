import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/domain/repository/auth.repository.dart';

import '../../../../core/constant/enums/status.enum.dart';
import '../../../../core/utils/exception/error_response.dart';
import '../../../model/result/result.dart';
import '../../base/remote.usecase.dart';

class GoogleSignInUseCase extends RemoteUseCase<AuthRepository> {
  GoogleSignInUseCase();

  @override
  Future call(AuthRepository repository) async {
    final result = await repository.signInWithGoogle();
    return result.status == ResponseStatus.success
        ? Result<UserCredential>.success(result.data!)
        : Result<UserCredential>.failure(ErrorResponse(
            status: 'ERROR', code: result.code, message: result.message));
  }
}
