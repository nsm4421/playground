import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/domain/usecase/user/edit_profile.usecase.dart';
import 'package:my_app/domain/usecase/user/get_current_user.usecase.dart';
import 'package:my_app/domain/usecase/user/user.usecase.dart';
import 'package:my_app/presentation/bloc/user/user.event.dart';
import 'package:my_app/presentation/bloc/user/user.state.dart';

import '../../../core/enums/status.enum.dart';
import '../../../core/response/result.dart';
import '../../../domain/model/auth/user.model.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase _userUseCase;

  UserBloc(this._userUseCase) : super(const UserState()) {
    on<InitProfile>(_onInit);
    on<EditProfile>(_onEditProfile);
  }

  /// 유저 정보 초기화
  Future<void> _onInit(InitProfile event, Emitter<UserState> emit) async {
    try {
      final response = await _userUseCase.execute<Result<UserModel>>(
          useCase: GetCurrentUserUseCase());
      response.when(success: (user) {
        emit(state.copyWith(status: Status.success, user: user));
      }, failure: (_) {
        emit(state.copyWith(status: Status.error));
      });
    } catch (err) {
      emit(state.copyWith(status: Status.error, error: err));
    }
  }

  /// 프로필 수정
  Future<void> _onEditProfile(
      EditProfile event, Emitter<UserState> emit) async {
    try {
      final response = await _userUseCase.execute<Result<UserModel>>(
          useCase: EditProfileUseCase(
              nickname: event.nickname,
              profileImageData: event.profileImageData));
      response.when(success: (user) {
        emit(state.copyWith(status: Status.success, user: user));
      }, failure: (_) {
        emit(state.copyWith(status: Status.error));
      });
    } catch (err) {
      emit(state.copyWith(status: Status.error, error: err));
    }
  }
}
