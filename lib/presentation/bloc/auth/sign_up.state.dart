part of '../export.bloc.dart';

class SignUpState extends SimpleBlocState {
  final String email;
  final String username;
  final String nickname;
  final String password;
  final XFile? profileImage;

  SignUpState({
    super.status,
    super.errorMessage,
    this.email = '',
    this.username = '',
    this.nickname = '',
    this.password = '',
    this.profileImage,
  });

  @override
  SignUpState copyWith({
    Status? status,
    String? errorMessage,
    String? email,
    String? username,
    String? nickname,
    String? password,
  }) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      password: password ?? this.password,
      profileImage: this.profileImage
    );
  }

  SignUpState copyWithProfileImage(XFile? profileImage) {
    return SignUpState(
      status: this.status,
      errorMessage: this.errorMessage,
      email: this.email,
      username: this.username,
      nickname: this.nickname,
      password: this.password,
      profileImage: profileImage,
    );
  }
}
