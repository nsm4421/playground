part of 'abstract.dart';

abstract class BaseEntity {
  final String? id;
  final String? createdAt;
  final String? updatedAt;

  BaseEntity({this.id, this.createdAt, this.updatedAt});
}
