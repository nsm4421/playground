import 'package:image_picker/image_picker.dart';

import '../../../core/enums/response_status.enum.dart';
import '../../../core/response/error_response.dart';
import '../../../core/response/result.dart';
import '../../model/auth/user_metadata.model.dart';
import '../../repository/auth/auth.repository.dart';
import '../base/remote.usecase.dart';

class EditUserMetaDataUseCase extends RemoteUseCase<AuthRepository> {
  final String nickname;
  final XFile? profileImageData;

  EditUserMetaDataUseCase({required this.nickname, this.profileImageData});

  @override
  Future call(AuthRepository repository) async {
    final res = await repository.editProfile(
        nickname: nickname, profileImageData: profileImageData);
    switch (res.status) {
      case ResponseStatus.success:
        return Result<UserMetaDataModel>.success(res.data!);
      default:
        return Result<UserMetaDataModel>.failure(
            ErrorResponse.fromResponseWrapper(res));
    }
  }
}
