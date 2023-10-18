import '../../../../../model/user/user.model.dart';

abstract class SwipeEvent {
  const SwipeEvent();
}

class SwipeInitEvent extends SwipeEvent {
  SwipeInitEvent();
}

class LoadUsersEvent extends SwipeEvent {
  final List<UserModel> users;

  LoadUsersEvent(this.users);
}

class SwipeLeftEvent extends SwipeEvent {
  final UserModel user;

  SwipeLeftEvent(this.user);
}

class SwipeRightEvent extends SwipeEvent {
  final UserModel user;

  SwipeRightEvent(this.user);
}
