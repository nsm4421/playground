import 'package:json_annotation/json_annotation.dart';

part 'base.model.g.dart';

@JsonSerializable()
class BaseModel {
  final String? id;
  final String? createdAt;
  final String? createdBy;
  final String? modifiedAt;
  final String? modifiedBy;
  final String? removedAt;

  BaseModel({
    this.id,
    this.createdAt,
    this.createdBy,
    this.modifiedAt,
    this.modifiedBy,
    this.removedAt,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}
