import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_registrations.freezed.dart';

part 'fetch_registrations.g.dart';

@freezed
class FetchRegistrationsModel with _$FetchRegistrationsModel {
  const factory FetchRegistrationsModel(
      {@Default('') String id,
      @Default('') String meeting_id,
      @Default('') String manager_id,
      @Default('') String manager_username,
      @Default('') String manager_avatar_url,
      @Default('') String proposer_id,
      @Default('') String created_by,
      @Default('') String proposer_username,
      @Default('') String proposer_avatar_url,
      @Default('') String created_at}) = _FetchRegistrationsModel;

  factory FetchRegistrationsModel.fromJson(Map<String, dynamic> json) =>
      _$FetchRegistrationsModelFromJson(json);
}
