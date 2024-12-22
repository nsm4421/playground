part of '../export.core.dart';

enum Routes {
  signIn('/auth/sign-up'),
  signUp('/auth/sign-up');

  final String path;

  const Routes(this.path);
}
