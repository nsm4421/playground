import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/enums/sign_up.enum.dart';

part 'user.model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
      {String? email,
      String? nickname,
      Sex? sex,
      int? age,
      @Default(<String>[]) List<String> profileImageUrls,
      String? description,
      DateTime? createdAt}) = _UserModel;
}
