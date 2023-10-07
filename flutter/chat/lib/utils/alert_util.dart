import 'package:flutter/material.dart';

class AlertUtils {
  static void showSnackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
}
