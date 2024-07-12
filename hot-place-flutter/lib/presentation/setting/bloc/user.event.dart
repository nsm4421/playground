part of 'user.bloc.dart';

@immutable
sealed class UserEvent {}

final class InitUserEvent extends UserEvent {
  InitUserEvent();
}

final class SignInEvent extends UserEvent {
  SignInEvent();
}

final class UpdateUserEvent extends UserEvent {
  final UserEntity user;

  UpdateUserEvent(this.user);
}

final class ModifyProfileEvent extends UserEvent {
  final UserEntity currentUser;
  final String nickname;
  final File? image;

  ModifyProfileEvent(
      {required this.currentUser, required this.nickname, this.image});
}
