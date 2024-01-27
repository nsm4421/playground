import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/enums/sign_up.enum.dart';

part 'user.dto.freezed.dart';

part 'user.dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    @Default('') String? uid,
    @Default('') String? nickname,
    @Default('') String? email,
    @Default(Sex.male) Sex? sex,
    DateTime? birthday,
    @Default(<String>[]) List<String> profileImageUrls,
    @Default('') String? description,
    DateTime? createdAt,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
