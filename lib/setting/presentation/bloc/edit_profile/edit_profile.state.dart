part of 'edit_profile.cubit.dart';

class EditProfileState {
  final Status status;
  final String username;
  final File? profileImage;
  final String? errorMessage;
  final bool isUploading;

  EditProfileState(
      {this.status = Status.initial,
      this.username = '',
      this.profileImage,
      this.errorMessage,
      this.isUploading = false});

  EditProfileState copyWith(
      {Status? status,
      String? username,
      File? profileImage,
      bool updateProfileImage = false,
      String? errorMessage,
      bool? isUploading}) {
    return EditProfileState(
        status: status ?? this.status,
        username: username ?? this.username,
        profileImage: updateProfileImage ? profileImage : this.profileImage,
        errorMessage: errorMessage ?? this.errorMessage,
        isUploading: isUploading ?? this.isUploading);
  }
}
