import 'package:flutter/material.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:flutter_app/shared/style/style.export.dart';
import 'package:injectable/injectable.dart';
import 'package:pausable_timer/pausable_timer.dart';

part 'snackbar_item.widget.dart';
part 'snackbar_messsage.dart';
part 'snackbar.widget.dart';

@lazySingleton
class CustomSnakbar {
  final _globalKey =
      GlobalKey<SnakbarWidgetState>(debugLabel: 'snackbar-global-key');

  GlobalKey<SnakbarWidgetState> get globalKey => _globalKey;

  success(
      {String title = 'Success',
      IconData iconData = Icons.check,
      Duration? timeout,
      VoidCallback? onTap,
      Color? bgColor,
      Color? textColor,
      bool isShake = false}) {
    _globalKey.currentState?.add(SnackbarMessage(
        title: title,
        timeout: timeout ?? const Duration(milliseconds: 1500),
        iconData: iconData,
        onTap: onTap,
        bgColor: bgColor ?? AppColors.black,
        textColor: textColor ?? AppColors.white,
        isShake: isShake));
  }

  info(
      {String title = 'Info',
      required String description,
      IconData iconData = Icons.info,
      Duration? timeout,
      VoidCallback? onTap,
      Color? bgColor,
      Color? textColor,
      bool isShake = false}) {
    _globalKey.currentState?.add(SnackbarMessage(
        type: SnakbarType.info,
        title: title,
        description: description,
        timeout: timeout ?? const Duration(milliseconds: 1500),
        iconData: iconData,
        onTap: onTap,
        bgColor: bgColor ?? AppColors.black,
        textColor: textColor ?? AppColors.white,
        isShake: isShake));
  }

  error(
      {String title = 'Error',
      String? description,
      IconData iconData = Icons.error_outline,
      Duration? timeout,
      VoidCallback? onTap,
      Color? bgColor,
      Color? textColor,
      bool isShake = false}) {
    _globalKey.currentState?.add(SnackbarMessage(
        type: SnakbarType.error,
        title: title,
        description: description,
        timeout: timeout ?? const Duration(milliseconds: 1500),
        iconData: iconData,
        onTap: onTap,
        bgColor: bgColor ?? AppColors.black,
        textColor: textColor ?? AppColors.white,
        isShake: isShake));
  }
}
