import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/auth/user_metadata.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
      {String? id, String? email, UserMetaDataModel? metaData}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromUser(User? user) => UserModel(
      id: user?.id,
      email: user?.email,
      metaData: UserMetaDataModel.fromJson(user?.userMetadata ?? {}));
}
