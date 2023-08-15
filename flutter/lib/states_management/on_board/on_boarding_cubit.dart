import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat/chat.dart';
import 'package:flutter_prj/states_management/on_board/on_boarding_state.dart';

import '../../service/image_upload_service.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final IUserService _userService;
  final ImageUploadService _imageUploader;

  OnBoardingCubit(this._userService, this._imageUploader)
      : super(OnBoardingInitial());

  Future<void> connect(String username, File profileImage) async {
    emit(OnBoardingLoading());
    final profileImageUrl = await _imageUploader.uploadImage(profileImage);
    final user = User(
        username: username,
        photoUrl: profileImageUrl,
        active: true,
        lastSeen: DateTime.now());
    emit(OnBoardingSuccess(await _userService.connect(user)));
  }
}
