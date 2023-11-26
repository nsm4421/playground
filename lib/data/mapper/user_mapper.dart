import 'package:my_app/data/dto/user/user.dto.dart';
import 'package:my_app/domain/model/user/user.model.dart';

import '../../core/constant/enums/sign_up.enum.dart';

extension UserDtoEx on UserDto {
  UserModel toModel() => UserModel(
    uid:uid??'',
      email: email ?? '',
      nickname: nickname ?? '',
      sex: sex ?? Sex.male,
      birthday: birthday,
      profileImageUrls: profileImageUrls ?? [],
      description: description ?? '',
      createdAt: createdAt);
}

extension UserModelEx on UserModel {
  UserDto toDto() => UserDto(
      uid:uid??'',
      email: email ?? '',
      nickname: nickname ?? '',
      sex: sex ?? Sex.male,
      birthday: birthday,
      profileImageUrls: profileImageUrls ?? [],
      description: description ?? '',
      createdAt: createdAt);
}
