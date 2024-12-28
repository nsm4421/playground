part of '../export.core.dart';

enum Routes {
  auth('/auth'),
  signIn('/auth/sign-in', subPath: 'sign-in'),
  signUp('/auth/sign-up', subPath: 'sign-up'),
  home('/home'),
  chat('/chat'),
  chatRoom('/chat/room' , subPath: 'room'),
  ;

  final String path;
  final String? subPath;

  const Routes(this.path, {this.subPath});
}
