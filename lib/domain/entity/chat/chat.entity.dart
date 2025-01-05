part of '../export.entity.dart';

class ChatEntity {
  final String id;
  final String title;
  late final List<String> hashtags;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatEntity(
      {required this.id,
      required this.title,
      List<String>? hashtags,
      required this.createdAt,
      required this.updatedAt}) {
    this.hashtags = hashtags ?? [];
  }
}
