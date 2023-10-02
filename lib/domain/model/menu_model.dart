import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/menu_model.freezed.dart';

part '../generated/menu_model.g.dart';

@freezed
class MenuModel with _$MenuModel {
  const factory MenuModel({
    required String title,
    required int tabId,
  }) = _MenuModel;

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);
}
