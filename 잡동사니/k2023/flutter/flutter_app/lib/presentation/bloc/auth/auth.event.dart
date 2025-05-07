import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class UpdateAuthState extends AuthEvent {
  final User? user;

  UpdateAuthState({this.user});
}

class SignUpWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  SignUpWithEmailAndPassword({required this.email, required this.password});
}

class SignInWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword({required this.email, required this.password});
}

class SignOut extends AuthEvent {}
