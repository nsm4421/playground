part of 'cubit.dart';

class EditProfileState extends BaseState {
  EditProfileState({super.status, super.message});

  @override
  EditProfileState copyWith({Status? status, String? message}) {
    return EditProfileState(
        status: status ?? this.status, message: message ?? this.message);
  }
}
