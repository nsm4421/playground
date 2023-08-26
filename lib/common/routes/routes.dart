import 'package:chat_app/screen/auth/s_add_phone_number.dart';
import 'package:chat_app/screen/auth/s_add_user_info.dart';
import 'package:chat_app/screen/auth/s_pick_image.dart';
import 'package:chat_app/screen/chat/s_contract.dart';
import 'package:chat_app/screen/s_home.dart';
import 'package:chat_app/screen/util/s_page_not_found.dart';
import 'package:chat_app/screen/s_welcome.dart';
import 'package:chat_app/screen/auth/s_verify_number.dart';
import 'package:flutter/material.dart';

class CustomRoutes {
  static const String home = 'home';
  static const String contract = 'contract';

  /// auth
  static const String welcome = 'welcome';
  static const String addPhoneNumber = 'add-phone-number';
  static const String verifyNumber = 'verify-number';
  static const String addUserInfo = 'add-user-info';
  static const String pickProfileImage = 'pick-profile-image';

  static Route<dynamic> onGeneralRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case contract:
        return MaterialPageRoute(builder: (context) => const ContractScreen());

      /// auth
      case welcome:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case addPhoneNumber:
        return MaterialPageRoute(
            builder: (context) => const AddPhoneNumberScreen());
      case verifyNumber:
        final Map args = routeSettings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => VerifyNumberScreen(
                  smsCodeId: args['smsCodeId'],
                  phoneNumber: args['phoneNumber'],
                ));
      case addUserInfo:
        return MaterialPageRoute(
            builder: (context) => const AddUserInfoScreen());
      case pickProfileImage:
        return MaterialPageRoute(builder: (context) => const PickImageScreen());

      /// not found exception page
      default:
        return MaterialPageRoute(
            builder: (context) => const PageNotFoundScreen());
    }
  }
}
