import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/view_module_model.freezed.dart';

part '../generated/view_module_model.g.dart';

@freezed
class ViewModuleModel with _$ViewModuleModel {
  const factory ViewModuleModel({
    required String type,
    required String title,
    required String subtitle,
    required String imageUrl,
  }) = _ViewModuleModel;

  factory ViewModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ViewModuleModelFromJson(json);
}
