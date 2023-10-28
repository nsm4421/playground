import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.dto.freezed.dart';

part 'user.dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    @Default('') String? nickname,
    @Default(-1) int age,
    @Default('') String? profileImageUrl,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
