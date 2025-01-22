part of '../export.core.dart';

enum Routes {
  /// auth
  auth('/auth'),
  signIn('/auth/sign-in', subPath: 'sign-in'),
  signUp('/auth/sign-up', subPath: 'sign-up'),
  passwordRecovery('/auth/password-recovery', subPath: 'password-recovery'),

  /// chat
  chat('/chat'),
  createChat('/chat/create', subPath: 'create'),
  chatRoom('/chat/room', subPath: 'room'),

  /// group chat
  groupChat('/chat/group', subPath: 'group'),
  createGroupChat('/chat/group/create', subPath: 'create'),
  groupChatRoom('/chat/group/room', subPath: 'room'),

  /// feed
  feed('/feed'),
  createFeed('/feed/create', subPath: 'create'),
  editFeed('/feed/edit', subPath: 'edit'),

  /// setting
  setting('/setting'),
  editProfile('/setting/edit-profile', subPath: 'edit-profile'),
  ;

  final String path;
  final String? subPath;

  const Routes(this.path, {this.subPath});
}
