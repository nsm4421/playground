import 'package:my_app/data/dto/user/user.dto.dart';
import 'package:my_app/domain/model/user/user.model.dart';

import '../../core/constant/enums/sign_up.enum.dart';

extension UserDtoEx on UserDto {
  UserModel toModel() => UserModel(
      email: email ?? '',
      nickname: nickname ?? '',
      sex:sex??Sex.male,
      age: age ?? -1,
      profileImageUrls: profileImageUrls ?? [],
      description: description??'',
      createdAt: createdAt);
}
