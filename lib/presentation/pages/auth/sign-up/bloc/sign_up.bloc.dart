import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/constant/enums/sign_up.enum.dart';
import 'package:my_app/domain/model/user/user.model.dart';
import 'package:my_app/domain/usecase/auth/auth.usecase.dart';
import 'package:my_app/domain/usecase/auth/sign_in/google_sign_in.usecase.dart';
import 'package:my_app/domain/usecase/auth/sign_in/on_boarding_initialized.usecase.dart';
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
      // 구글계정으로 회원가입
      (await _authUseCase.execute(useCase: GoogleSignInUseCase())).when(
          success: (credential) {
        emit(state.copyWith(
            uid: credential.user?.uid,
            user: UserModel(
                email: credential.additionalUserInfo?.profile!['email'],
                sex: null)));
      }, failure: (err) {
        emit(state.copyWith(status: SignUpStatus.error, error: err));
      });
      // 이미 회원정보가 등록된 회원이면 Status를 AlreadySignUp
      // 회원정보가 등록된적이 없는 경우(createdAt 필드가 null)이면 Status를 OnBoarding으로 업데이트
      (await _authUseCase.execute(useCase: OnBoardingInitializedUseCase()))
          .when(success: (UserModel? user) {
        final onBoardDone = user?.createdAt != null;
        emit(state.copyWith(
            status: onBoardDone
                ? SignUpStatus.alreadySignUp
                : SignUpStatus.onBoarding));
      }, failure: (err) {
        emit(state.copyWith(
            status: SignUpStatus.error, error: CommonException.setError(err)));
      });
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(
          status: SignUpStatus.error, error: CommonException.setError(err)));
    }
  }

  /// 회원정보 상태 업데이트
  void _updateOnBoardState(
      UpdateOnBoardStateEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(images: event.state.images, user: event.state.user));
  }

  /// 회원정보 제출
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
