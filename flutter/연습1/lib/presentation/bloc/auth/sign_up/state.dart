part of 'cubit.dart';

class SignUpState extends BaseState {
  final String email;
  final String password;
  final String username;
  final File? profileImage;

  SignUpState(
      {super.status,
      super.message,
      this.email = '',
      this.password = '',
      this.username = '',
      this.profileImage});

  SignUpState _copyWith(
      {Status? status,
      String? message,
      String? email,
      String? password,
      String? username,
      File? profileImage}) {
    return SignUpState(
        status: status ?? this.status,
        message: message ?? this.message,
        email: email ?? this.email,
        password: password ?? this.password,
        username: username ?? this.username,
        profileImage: profileImage);
  }

  @override
  SignUpState copyWith(
      {Status? status,
      String? message,
      String? email,
      String? password,
      String? username}) {
    return _copyWith(
        status: status,
        message: message,
        email: email,
        password: password,
        username: username,
        profileImage: profileImage);
  }

  SignUpState copyWithProfileImage(File? profileImage) {
    return _copyWith(profileImage: profileImage);
  }
}
