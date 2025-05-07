import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/domain/entity/auth/presence.dart';
import 'package:travel/domain/usecase/auth/usecase.dart';

part 'state.dart';

class EditProfileCubit extends Cubit<EditProfileState> with CustomLogger {
  final AuthUseCase _useCase;
  PresenceEntity _currentUser;

  PresenceEntity get currentUser => _currentUser;

  EditProfileCubit(this._currentUser, {required AuthUseCase useCase})
      : _useCase = useCase,
        super(EditProfileState());

  void init({Status? status = Status.initial, String? message = ''}) async {
    emit(state.copyWith(status: status, message: message));
    logger.t('status:$status|message:$message');
  }

  Future<void> submit({required String username, File? profileImage}) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .editProfile(
              username: username == _currentUser.username
                  ? null
                  : username,
              profileImage: profileImage)
          .then((res) => res.fold(
                  (l) => emit(
                      state.copyWith(status: Status.error, message: l.message)),
                  (r) {
                _currentUser = r!;
                emit(state.copyWith(status: Status.success));
              }));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error));
    }
  }
}
