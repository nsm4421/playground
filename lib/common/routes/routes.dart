import 'package:chat_app/screen/s_add_phone_number.dart';
import 'package:chat_app/screen/s_add_user_info.dart';
import 'package:chat_app/screen/s_welcome.dart';
import 'package:chat_app/screen/s_page_not_found.dart';
import 'package:chat_app/screen/s_verify_number.dart';
import 'package:flutter/material.dart';

class CustomRoutes {
  static const String welcome = 'welcome';
  static const String addPhoneNumber = 'add-phone-number';
  static const String verifyNumber = 'verify-number';
  static const String addUserInfo = 'add-user-info';

  static Route<dynamic> onGeneralRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case welcome:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case addPhoneNumber:
        return MaterialPageRoute(
            builder: (context) => const AddPhoneNumberScreen());
      case verifyNumber:
        final Map args = routeSettings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => VerifyNumberScreen(
                  countryCode: args['countryCode'],
                  phoneNumber: args['phoneNumber'],
                ));
      case addUserInfo:
        return MaterialPageRoute(
            builder: (context) => const AddUserInfoScreen());

      /// not found exception page
      default:
        return MaterialPageRoute(
            builder: (context) => const PageNotFoundScreen());
    }
  }
}
