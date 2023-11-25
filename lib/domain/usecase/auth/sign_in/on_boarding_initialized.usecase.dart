import 'package:my_app/domain/model/user/user.model.dart';

import '../../../../core/constant/enums/status.enum.dart';
import '../../../../core/utils/exception/error_response.dart';
import '../../../model/result/result.dart';
import '../../../repository/auth.repository.dart';
import '../../base/remote.usecase.dart';

class OnBoardingInitializedUseCase extends RemoteUseCase<AuthRepository> {
  OnBoardingInitializedUseCase();

  @override
  Future call(AuthRepository repository) async {
    final result = await repository.getCurrentUserInfo();
    return result.status == ResponseStatus.success
        ? Result<UserModel?>.success(result.data)
        : Result<UserModel?>.failure(ErrorResponse(
            status: 'ERROR', code: result.code, message: result.message));
  }
}
