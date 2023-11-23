import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/domain/model/user/user.model.dart';

import '../../../../core/constant/enums/status.enum.dart';
import '../../../../core/utils/exception/error_response.dart';
import '../../../model/result/result.dart';
import '../../../repository/auth.repository.dart';
import '../../base/remote.usecase.dart';

class SubmitOnBoardingFormUseCase extends RemoteUseCase<AuthRepository> {
  SubmitOnBoardingFormUseCase(
      {required this.uid, required this.user, required this.images});

  final String uid;
  final UserModel user;
  final List<Asset> images;

  @override
  Future call(AuthRepository repository) async {
    final result = await repository.submitOnBoardingForm(uid:uid, user: user, images: images);
    return result.status == ResponseStatus.success
        ? Result.success(result.data)
        : Result.failure(ErrorResponse(
            status: 'ERROR', code: result.code, message: result.message));
  }
}
