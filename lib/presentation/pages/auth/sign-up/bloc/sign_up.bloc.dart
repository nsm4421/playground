import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/constant/enums/sign_up.enum.dart';
import 'package:my_app/domain/model/user/user.model.dart';
import 'package:my_app/domain/usecase/auth/auth.usecase.dart';
import 'package:my_app/domain/usecase/auth/sign_in/google_sign_in.usecase.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.event.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.state.dart';

import '../../../../../core/utils/exception/custom_exception.dart';
import '../../../../../core/utils/logging/custom_logger.dart';
import '../../../../../domain/usecase/auth/sign_in/submit_on_boarding_form.usecase.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthUseCase _authUseCase;

  SignUpBloc(this._authUseCase) : super(const SignUpState()) {
    on<GoogleSignUpEvent>(_googleSignUp);
    on<UpdateOnBoardStateEvent>(_updateOnBoardState);
    on<SubmitOnBoardingFormEvent>(_submitOnBoardingForm);
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
        if (!credential.additionalUserInfo.isNewUser) {
          // TODO : On Boarding 여부 판단 - 이미 했으면 로그인페이지로, 아니면 On Boarding 페이지로
          // emit(state.copyWith(status: SignUpStatus.alreadySignUp));
          // return;
        }
        // 처음 회원가입하는 경우
        final uid = credential.user?.uid;
        final email = credential.additionalUserInfo?.profile['email'];
        if (uid == null || email == null) throw Exception('회원가입되지 않은 회원입니다');
        emit(state.copyWith(
            status: SignUpStatus.onBoarding,
            uid: uid,
            user: UserModel(email: email, sex: null)));
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

  Future<void> _submitOnBoardingForm(
      SubmitOnBoardingFormEvent event, Emitter<SignUpState> emit) async {
    try {
      emit(state.copyWith(status: SignUpStatus.loading));
      final response = await _authUseCase.execute(
          useCase: SubmitOnBoardingFormUseCase(
              uid: state.uid, user: state.user, images: state.images));
      response.when(success: (_) {
        emit(state.copyWith(status: SignUpStatus.done));
      }, failure: (err) {
        emit(state.copyWith(status: SignUpStatus.error, error: err));
      });
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(
          status: SignUpStatus.error, error: CommonException.setError(err)));
    }
  }
}
