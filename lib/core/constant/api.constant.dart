part of '../export.core.dart';

class ApiEndPoint {
  static const domain = "http://10.0.2.2:3000";
  static const baseUrl = "$domain/api";

  /// auth
  static String auth = "/auth";

  /// feed
  static String feed = "/feed";

  /// chat
  static String chat = "/chat";
  static const socketUrl = "http://10.0.2.2:3001";
}

class EventNames {
  static const joinChat = "join-chat";
  static const sendMessage = "send-message";
  static const receiveMessage = "receive-message";
}

enum ReactionReference {
  feeds("/feed/reaction");

  final String endPoint;

  const ReactionReference(this.endPoint);
}

enum CommentReference {
  feeds("/feed/comment");

  final String endPoint;

  const CommentReference(this.endPoint);
}
