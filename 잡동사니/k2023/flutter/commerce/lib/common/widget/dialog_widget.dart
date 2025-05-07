import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/error/error_response.dart';

class DialogWidget {
  static const double _height = 100;

  const DialogWidget();

  static Future<bool?> errorDialog(
    BuildContext context,
    ErrorResponse errorResponse,
  ) =>
      showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          content: SizedBox(
            height: _height,
            child: Column(
              children: [Text(errorResponse.message ?? "에러가 발생했습니다")],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => context.pop(true),
              child: Text('Try Again'),
            ),
            ElevatedButton(onPressed: () => exit(0), child: Text('Quit App')),
          ],
          actionsAlignment: MainAxisAlignment.center,
        ),
      );
}
