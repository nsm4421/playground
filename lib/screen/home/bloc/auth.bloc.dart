import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/domain/model/user/user.model.dart';
import 'package:my_app/screen/home/bloc/auth.event.dart';
import 'package:my_app/screen/home/bloc/auth.state.dart';
import 'package:my_app/usecase/auth/auth.usecase.dart';
import 'package:my_app/usecase/auth/get_current_user.usecase.dart';
import 'package:my_app/usecase/auth/sign_out.usecase.dart';

import '../../../core/response/response.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase _authUsecase;

  AuthBloc(this._authUsecase) : super(const AuthState()) {
    on<InitAuthEvent>(_onInit);
    on<SignOutEvent>(_onSignOut);
  }

  _onInit(InitAuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final Response<UserModel?> response =
          await _authUsecase.execute(useCase: GetCurrentUserUsecase());
      if (response.status == Status.success && response.data?.uid != null) {
        emit(state.copyWith(
          status: AuthStatus.success,
          uid: response.data!.uid!,
          nickname: response.data!.nickname ?? 'Anonymous',
          profileImageUrls: response.data?.profileImageUrls ?? [],
        ));
      } else {
        emit(state.copyWith(status: AuthStatus.error));
      }
    } catch (err) {
      emit(state.copyWith(status: AuthStatus.error));
    }
  }

  _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await _authUsecase.execute(useCase: SignOutUsecase());
    } catch (err) {
      emit(state.copyWith(status: AuthStatus.error));
    }
  }
}
