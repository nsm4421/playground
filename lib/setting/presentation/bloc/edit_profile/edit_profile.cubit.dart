import 'dart:developer';
import 'dart:io';

import 'package:flutter_app/setting/domain/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/shared.export.dart';

part 'edit_profile.state.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final CustomMediaUtil _util;
  final AccountUseCase _useCase;

  EditProfileCubit(
      {required CustomMediaUtil util, required AccountUseCase useCase})
      : _util = util,
        _useCase = useCase,
        super(EditProfileState());

  void init({Status? status, String? username}) {
    emit(state.copyWith(
        status: status ?? state.status, username: username ?? state.username));
  }

  Future<bool> checkUsername() async {
    return await _useCase.checkUsername(state.username).then((res) => res.ok);
  }

  Future<void> selectImage({String filename = 'profile-image.jpg'}) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final selected = await _util.pickCompressedImage(filename: filename);
      if (selected != null) {
        emit(state.copyWith(
            status: Status.success,
            profileImage: selected,
            updateProfileImage: true));
      }
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, errorMessage: '사진 선택 중 오류가 발생했습니다'));
    }
  }

  void unSelectImage() {
    try {
      emit(state.copyWith(
          status: Status.success,
          profileImage: null,
          updateProfileImage: true));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, errorMessage: '사진 선택 중 오류가 발생했습니다'));
    }
  }

  Future<void> submit() async {
    emit(state.copyWith(status: Status.loading, isUploading: true));
    final res = await _useCase.editProfile(
        username: state.username, image: state.profileImage);
    if (res.ok) {
      emit(state.copyWith(status: Status.success));
    } else {
      emit(state.copyWith(
          status: Status.error, isUploading: false, errorMessage: res.message));
    }
  }
}
