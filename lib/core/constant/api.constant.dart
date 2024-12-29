part of '../export.core.dart';

class ApiEndPoint {
  static const baseUrl = "http://10.0.2.2:3000/api";

  /// auth
  static String signUp = "/auth/sign-up";
  static String signIn = "/auth/sign-in";
  static String getUser = "/auth";

  /// feed
  static String createFeed = "/feed";
  static String modifyFeed = "/feed";
  static String deleteFeed = "/feed";
}
