part of '../export.entity.dart';

class ReactionEntity {
  final int id;
  final DateTime? createdAt;

  ReactionEntity({required this.id, this.createdAt});

  factory ReactionEntity.from(ReactionDto dto) {
    return ReactionEntity(
        id: dto.id, createdAt: DateTime.tryParse(dto.createdAt));
  }
}
