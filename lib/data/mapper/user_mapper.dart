import 'package:my_app/data/dto/user/user.dto.dart';
import 'package:my_app/domain/model/user/user.model.dart';

extension UserDtoEx on UserDto {
  UserModel toModel() => UserModel(
      nickname: nickname ?? '',
      age: age ?? -1,
      profileImageUrl: profileImageUrl ?? '',
      createdAt: createdAt);
}
