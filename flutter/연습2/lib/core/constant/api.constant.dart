part of '../export.core.dart';

class ApiEndPoint {
  static const domain = "http://10.0.2.2:3000";
  static const baseUrl = "$domain/api";

  /// auth
  static String auth = "/auth";

  /// feed
  static String feed = "/feed";

  /// chat
  static String groupChat = "/group-chat";
  static String privateChat = "/private-chat";
  static const socketUrl = "http://10.0.2.2:3001";
}

class EventNames {
  static const joinGroupChat = "join-group-chat";
  static const leaveGroupChat = "leave-group-chat";
  static const sendGroupChatMessage = "send-group-chat-message";
  static const receiveGroupChatMessage = "receive-group-chat-message";

  static const sendPrivateChatMessage = "send-private-chat-message";
  static const receivePrivateChatMessage = "receive-private-chat-message";
  static const deletePrivateChatMessage = "delete-private-chat-message";
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
