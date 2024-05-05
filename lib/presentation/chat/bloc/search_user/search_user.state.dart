import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/constant/user.constant.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../../core/constant/response.constant.dart';

part 'search_user.state.freezed.dart';

part 'search_user.state.g.dart';

@freezed
class SearchUserState with _$SearchUserState {
  const factory SearchUserState(
      {@Default(Status.initial) Status status,
      @Default(UserSearchType.nickname) UserSearchType type,
      @Default('') String keyword,
      @Default(<UserEntity>[]) List<UserEntity> users,
      @Default('') String errorMessage}) = _SearchUserState;

  factory SearchUserState.fromJson(Map<String, dynamic> json) =>
      _$SearchUserStateFromJson(json);
}
