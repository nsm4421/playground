part of '../export.core.dart';

class Entity {}

class BaseEntity extends Entity {
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BaseEntity({this.createdAt, this.updatedAt});
}

class IntIdEntity extends BaseEntity {
  final int id;

  IntIdEntity({super.createdAt, super.updatedAt, required this.id});
}

class UuidIdEntity extends BaseEntity {
  final String id;

  UuidIdEntity({super.createdAt, super.updatedAt, required this.id});
}
