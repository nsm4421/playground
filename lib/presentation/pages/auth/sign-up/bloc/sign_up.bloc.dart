import 'package:firebase_auth/firebase_auth.dart';
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
import '../../../../../domain/usecase/auth/sign_in/submit_user_info.usecase.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthUseCase _authUseCase;

  SignUpBloc(this._authUseCase) : super(const SignUpState()) {
    on<GoogleSignUpEvent>(_googleSignUp);
    on<UpdateOnBoardStateEvent>(_updateOnBoardState);
    on<SubmitUserInfoEvent>(_submitUserInfo);
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
        // On Boarding 여부 판단 - 이미 했으면 로그인페이지로, 아니면 On Boarding 페이지로
        //   emit(state.copyWith(status: SignUpStatus.alreadySignUp));
        //   return;
        // }
        // 처음 회원가입하는 경우
        final uid = credential.user?.uid;
        final email = credential.additionalUserInfo?.profile['email'];
        if (uid == null || email == null) throw Exception('회원가입되지 않은 회원입니다');
        emit(state.copyWith(
            status: SignUpStatus.onBoarding,
            uid: uid,
            user: UserDto(email: email, sex: null)));
      }, failure: (err) {
        emit(state.copyWith(status: SignUpStatus.error, error: err));
      });
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(
          status: SignUpStatus.error, error: CommonException.setError(err)));
    }
  }

  void _updateOnBoardState(
      UpdateOnBoardStateEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(images: event.state.images, user: event.state.user));
  }

  void _submitUserInfo(
      SubmitUserInfoEvent event, Emitter<SignUpState> emit) async {
    try {
      emit(state.copyWith(status: SignUpStatus.loading));
      final response = await _authUseCase.execute(
          useCase:
              SubmitUserInfoUseCase(uid:state.uid, user: state.user, images: state.images));

      emit(state.copyWith(status: SignUpStatus.done));
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(
          status: SignUpStatus.error, error: CommonException.setError(err)));
    }
  }
}
