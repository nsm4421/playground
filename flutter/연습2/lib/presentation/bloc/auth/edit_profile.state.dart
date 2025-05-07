part of '../export.bloc.dart';

class EditProfileState extends SimpleBlocState {
  final String nickname;
  final XFile? profileImage;

  EditProfileState({
    super.status,
    super.errorMessage,
    this.nickname = '',
    this.profileImage,
  });

  @override
  EditProfileState copyWith({
    Status? status,
    String? errorMessage,
    String? email,
    String? username,
    String? nickname,
    String? password,
  }) {
    return EditProfileState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        nickname: nickname ?? this.nickname,
        profileImage: this.profileImage);
  }

  EditProfileState copyWithProfileImage(XFile? profileImage) {
    return EditProfileState(
      status: this.status,
      errorMessage: this.errorMessage,
      nickname: this.nickname,
      profileImage: profileImage,
    );
  }
}
