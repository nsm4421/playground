import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/features/app/constant/user.constant.dart';
import 'package:hot_place/features/user/domain/usecase/sign_up/verify_phone_number.usecase.dart';
import 'package:hot_place/features/user/presentation/bloc/phone_sign_up/sign_up.event.dart';
import 'package:hot_place/features/user/presentation/bloc/phone_sign_up/sign_up.state.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required VerifyPhoneNumberUseCase verifyPhoneNumberUseCase})
      : _verifyPhoneNumberUseCase = verifyPhoneNumberUseCase,
        super(const SignUpState()) {
    on<SignUpInit>(_onInit);
    on<VerifyPhoneNumber>(_verifyPhoneNumber);
    on<VerifyOtpCode>(_verifyOtpCode);
  }

  final VerifyPhoneNumberUseCase _verifyPhoneNumberUseCase;
  final Logger _logger = Logger();

  void _onInit(SignUpInit event, Emitter<SignUpState> emit) {
    // TODO : 이미 회원가입했는지 여부 확인
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(isLoading: false));
  }

  void _verifyPhoneNumber(
      VerifyPhoneNumber event, Emitter<SignUpState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final phoneNumber = event.phoneNumber;
      await _verifyPhoneNumberUseCase(phoneNumber);
      emit(state.copyWith(step: SignUpStep.otp, phoneNumber: phoneNumber));
    } catch (err) {
      _logger.e(err);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _verifyOtpCode(VerifyOtpCode event, Emitter<SignUpState> emit) {}
}
