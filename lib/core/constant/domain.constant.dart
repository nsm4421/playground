part of 'constant.dart';

class BaseEntity {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;

  BaseEntity({this.id, this.createdAt, this.updatedAt, this.createdBy});
}
