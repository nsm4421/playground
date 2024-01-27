import 'package:image_picker/image_picker.dart';

abstract class UserEvent {
  const UserEvent();
}

class InitProfile extends UserEvent {}

class EditProfile extends UserEvent {
  final String? nickname;
  final XFile? profileImageData;

  EditProfile({this.nickname, this.profileImageData});
}
