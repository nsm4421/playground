part of 'abstract.dart';

abstract class BaseEntity {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BaseEntity({this.id, this.createdAt, this.updatedAt});
}
