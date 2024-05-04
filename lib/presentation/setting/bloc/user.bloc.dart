import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/usecase/auth/auth.usecase.dart';
import 'package:hot_place/domain/usecase/user/user.usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constant/response.constant.dart';
import 'user.state.dart';

part "user.event.dart";

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthUseCase _authUseCase;
  final UserUseCase _userUseCase;

  UserBloc({required AuthUseCase authUseCase, required UserUseCase userUseCase})
      : _authUseCase = authUseCase,
        _userUseCase = userUseCase,
        super(const UserState()) {
    on<InitUserEvent>(_onInit);
    on<SignInEvent>(_onSignIn);
    on<ModifyProfileEvent>(_onModifyProfile);
  }

  void _onInit(InitUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final currentUid = _authUseCase.getCurrentUser().fold((l) {
      throw Exception('getting current user fail');
    }, (r) => r.id);
    final res = await _userUseCase.getProfile(currentUid!);
    res.fold(
        (l) => emit(state.copyWith(
            status: Status.error,
            error: l.message ?? 'getting current profile fails')),
        (r) => emit(state.copyWith(status: Status.initial, user: r)));
  }

  void _onSignIn(SignInEvent event, Emitter<UserState> emit) async {
    try {
      final lastSeenAt =
          await _userUseCase.updateLastSeenAt().then((res) => res.fold((l) {
                debugPrint(l.message ?? 'last_seen_at 필드 업데이트 중 오류 발생');
                return DateTime.now();
              }, (r) => r));
      emit(state.copyWith(user: state.user.copyWith(lastSeenAt: lastSeenAt)));
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  void _onModifyProfile(
      ModifyProfileEvent event, Emitter<UserState> emit) async {
    try {
      String? profileImage;
      emit(state.copyWith(status: Status.loading));
      // 프로필 이미지 수정
      if (event.image != null) {
        profileImage = (await _userUseCase.upsertProfileImage(event.image!))
            .getOrElse((l) {
          throw Exception('프로필 업로드 중 오류가 발생했습니다');
        });
      }
      // 유저 정보 저장
      final res = await _userUseCase.modifyProfile(
          currentUser: event.currentUser,
          nickname: event.nickname,
          profileImage: profileImage);
      res.fold(
          (l) => emit(state.copyWith(
              status: Status.error, error: l.message ?? '닉네임 수정 중 오류가 발생했습니다')),
          (r) => emit(state.copyWith(status: Status.success, user: r)));
    } catch (err) {
      emit(state.copyWith(status: Status.error, error: '닉네임 수정 중 오류가 발생했습니다'));
      debugPrint(err.toString());
    }
  }
}
