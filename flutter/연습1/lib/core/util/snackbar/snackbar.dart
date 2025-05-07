import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:travel/core/util/extension/extension.dart';

import '../../theme/theme.dart';

part 'w_snackbar_item.dart';

part 'w_snackbar.dart';

// 다음 Git Repo의 SnackBar코드를 가져와 수정함
// https://github.com/Gambley1/flutter-instagram-offline-first-clone/tree/main

@lazySingleton
class CustomSnackBar {
  final _snackbarKey = GlobalKey<SnackBarWidgetState>();

  @lazySingleton
  GlobalKey<SnackBarWidgetState> get snackbarKey => _snackbarKey;

  success(
      {required String title,
      String? description,
      bool clearIfQueue = false,
      bool undismissable = false}) {
    _snackbarKey.currentState?.post(
        SnackBarMessageItem.success(title: title, description: description),
        clearIfQueue: clearIfQueue,
        undismissable: undismissable);
  }

  warning(
      {required String title,
      bool clearIfQueue = false,
      bool undismissable = false}) {
    _snackbarKey.currentState?.post(
        SnackBarMessageItem(
          icon: Icons.warning_amber,
          title: title,
          backgroundColor: CustomPalette.darkGrey,
        ),
        clearIfQueue: clearIfQueue,
        undismissable: undismissable);
  }

  error(
      {required String title,
      String? description,
      bool clearIfQueue = false,
      bool undismissable = false}) {
    _snackbarKey.currentState?.post(
        SnackBarMessageItem.error(title: title, description: description),
        clearIfQueue: clearIfQueue,
        undismissable: undismissable);
  }

  closeAll() {
    _snackbarKey.currentState?.closeAll();
  }
}
