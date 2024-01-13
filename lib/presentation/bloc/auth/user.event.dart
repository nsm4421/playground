import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/model/auth/user_metadata.model.dart';

abstract class UserEvent {
  const UserEvent();
}

class UpdateUserState extends UserEvent {
  final User? user;

  UpdateUserState(this.user);
}

class SignUpWithEmailAndPassword extends UserEvent {
  final String email;
  final String password;

  SignUpWithEmailAndPassword({required this.email, required this.password});
}

class SignInWithEmailAndPassword extends UserEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword({required this.email, required this.password});
}

class SignOut extends UserEvent {}

class EditUserMetaData extends UserEvent {
  final UserMetaDataModel metaData;

  EditUserMetaData(this.metaData);
}
