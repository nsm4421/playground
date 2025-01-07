part of '../export.entity.dart';

class ChatEntity extends IntIdEntity {
  final String title;
  late final List<String> hashtags;

  ChatEntity(
      {required super.id,
      required this.title,
      List<String>? hashtags,
      super.createdAt,
      super.updatedAt}) {
    this.hashtags = hashtags ?? [];
  }
}
