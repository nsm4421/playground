part of '../export.core.dart';

class ApiEndPoint {
  static const domain = "http://10.0.2.2:3000";
  static const baseUrl = "$domain/api";

  /// auth
  static String signUp = "/auth/sign-up";
  static String signIn = "/auth/sign-in";
  static String editProfile = "/auth/edit-profile";
  static String getUser = "/auth";

  /// feed
  static String fetchFeed = "/feed";
  static String createFeed = "/feed";
  static String modifyFeed = "/feed";
  static String deleteFeed = "/feed";

  /// chat
  static String createChat = "/chat";
  static String fetchChat = "/chat";
  static const socketUrl = "http://10.0.2.2:3001";
}

class EventNames {
  static const joinChat = "join-chat";
  static const sendMessage = "send-message";
  static const receiveMessage = "receive-message";
}
