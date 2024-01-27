import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';

import '../../../../core/constant/feed.enum.dart';
import '../../../../domain/model/user/user.model.dart';

part 'search.state.freezed.dart';

part 'search.state.g.dart';

enum SearchStatus {
  initial,
  loading,
  error,
  success;
}

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default(SearchStatus.initial) SearchStatus status,
    @Default(SearchOption.hashtag) SearchOption option,
    @Default('') String keyword,
    @Default(<FeedModel>[]) List<FeedModel> feeds,
    @Default(<UserModel>[]) List<UserModel> users,
  }) = _SearchState;

  factory SearchState.fromJson(Map<String, dynamic> json) =>
      _$SearchStateFromJson(json);
}
