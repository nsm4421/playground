import 'package:image_picker/image_picker.dart';
import 'package:my_app/domain/repository/user/user.repository.dart';

import '../../../core/enums/response_status.enum.dart';
import '../../../core/response/error_response.dart';
import '../../../core/response/result.dart';
import '../../model/auth/user.model.dart';
import '../base/remote.usecase.dart';

class EditProfileUseCase extends RemoteUseCase<UserRepository> {
  final String? nickname;
  final XFile? profileImageData;

  EditProfileUseCase({required this.nickname, this.profileImageData});

  @override
  Future call(UserRepository repository) async {
    // 업데이트 할 내용이 없는 경우 에러
    if (nickname == null && profileImageData == null) {
      return const Result<void>.failure(
          ErrorResponse(message: 'nothing to edit'));
    }

    // 프로필 업데이트
    final res = await repository.editProfile(
        nickname: nickname, profileImageData: profileImageData);

    // 유저정보 return
    return res.status == ResponseStatus.success
        ? Result<UserModel>.success(res.data!)
        : Result<UserModel>.failure(ErrorResponse.fromResponseWrapper(res));
  }
}
