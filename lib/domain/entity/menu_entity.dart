import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/menu_entity.freezed.dart';

part '../generated/menu_entity.g.dart';

@freezed
class MenuEntity with _$MenuEntity {
  const factory MenuEntity({
    required String title,
    required int tabId,
  }) = _MenuEntity;

  factory MenuEntity.fromJson(Map<String, dynamic> json) =>
      _$MenuEntityFromJson(json);
}
