import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/usecase/auth/get_current_user.usecase.dart';
import 'package:hot_place/domain/usecase/user/get_profile.usecase.dart';
import 'package:hot_place/domain/usecase/user/modify_profile.usecase.dart';
import 'package:hot_place/domain/usecase/user/upsert_profile_image.usecae.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constant/response.constant.dart';
import 'user.state.dart';

part "user.event.dart";

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUserUserCase _getCurrentUserUserCase;
  final GetProfileUseCase _getProfileUseCase;
  final ModifyProfileUseCase _modifyProfileUseCase;
  final UpsertProfileImageUseCase _upsertProfileImageUseCase;

  UserBloc(
      {required GetCurrentUserUserCase getCurrentUserUserCase,
      required GetProfileUseCase getProfileUseCase,
      required ModifyProfileUseCase modifyProfileUseCase,
      required UpsertProfileImageUseCase upsertProfileImageUseCase})
      : _getCurrentUserUserCase = getCurrentUserUserCase,
        _getProfileUseCase = getProfileUseCase,
        _modifyProfileUseCase = modifyProfileUseCase,
        _upsertProfileImageUseCase = upsertProfileImageUseCase,
        super(const UserState()) {
    on<InitUserEvent>(_onInit);
    on<ModifyProfileEvent>(_onModifyProfile);
  }

  void _onInit(InitUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final currentUid = _getCurrentUserUserCase().fold((l) {
      throw Exception('getting current user fail');
    }, (r) => r.id);
    final res = await _getProfileUseCase(currentUid!);
    res.fold(
        (l) => emit(state.copyWith(
            status: Status.error,
            error: l.message ?? 'getting current profile fails')),
        (r) => emit(state.copyWith(status: Status.initial, user: r)));
  }

  void _onModifyProfile(
      ModifyProfileEvent event, Emitter<UserState> emit) async {
    try {
      String? profileImage;
      emit(state.copyWith(status: Status.loading));
      // 프로필 이미지 수정
      if (event.image != null) {
        profileImage =
            (await _upsertProfileImageUseCase(event.image!)).getOrElse((l) {
          throw Exception('프로필 업로드 오류');
        });
      }
      // 유저 정보 저장
      final res = await _modifyProfileUseCase(
          currentUser: event.currentUser,
          nickname: event.nickname,
          profileImage: profileImage);
      res.fold(
          (l) => emit(state.copyWith(
              status: Status.error,
              error: l.message ?? 'error occurs on modify nickname')),
          (r) => emit(state.copyWith(status: Status.success, user: r)));
    } catch (err) {
      emit(state.copyWith(status: Status.error, error: err.toString()));
    }
  }
}
