import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/constant/enums/sign_up.enum.dart';
import 'package:my_app/data/dto/user/user.dto.dart';
import 'package:my_app/domain/usecase/auth/auth.usecase.dart';
import 'package:my_app/domain/usecase/auth/sign_in/google_sign_in.usecase.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.event.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.state.dart';

import '../../../../../core/utils/exception/custom_exception.dart';
import '../../../../../core/utils/logging/custom_logger.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthUseCase _authUseCase;

  SignUpBloc(this._authUseCase) : super(const SignUpState()) {
    on<GoogleSignUpEvent>(_googleSignUp);
    on<UpdateUserStateEvent>(_updateUserState);
  }

  /// 구글 계정으로 회원가입
  Future<void> _googleSignUp(
      GoogleSignUpEvent event, Emitter<SignUpState> emit) async {
    try {
      emit(state.copyWith(status: SignUpStatus.loading));
      // 회원가입 처리 후 인증정보 가져오기
      final response =
          await _authUseCase.execute(useCase: GoogleSignInUseCase());
      response.when(success: (credential) {
        // TODO :이미 회원가입한 경우 처리 주석 제거
        // if (!credential.additionalUserInfo.isNewUser) {
        //   emit(state.copyWith(status: SignUpStatus.alreadySignUp));
        //   return;
        // }
        // 처음 회원가입하는 경우
        final email = credential.additionalUserInfo?.profile['email'];
        emit(state.copyWith(
            status: SignUpStatus.onBoarding, user: UserDto(email: email)));
      }, failure: (err) {
        emit(state.copyWith(status: SignUpStatus.error, error: err));
      });
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(
          status: SignUpStatus.error, error: CommonException.setError(err)));
    }
  }

  void _updateUserState(UpdateUserStateEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(user: event.state.user));
  }
}
