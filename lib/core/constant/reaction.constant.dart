part of '../export.core.dart';

enum ReactionReference {
  feeds("/feed/reaction");

  final String endPoint;

  const ReactionReference(this.endPoint);
}