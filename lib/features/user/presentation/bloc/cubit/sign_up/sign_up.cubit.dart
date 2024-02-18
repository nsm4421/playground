import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/features/app/constant/user.constant.dart';
import 'package:hot_place/features/user/domain/usecase/sign_up/insert_user.usecase.dart';
import 'package:hot_place/features/user/domain/usecase/sign_up/verify_otp_number.usecase.dart';
import 'package:hot_place/features/user/domain/usecase/sign_up/verify_phone_number.usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class SignUpCubit extends Cubit<SignUpStep> {
  SignUpCubit({
    required this.insertUserUseCase,
    required this.verifyOtpNumber,
    required this.verifyPhoneNumberUseCase,
  }) : super(SignUpStep.initial);

  final InsertUserUseCase insertUserUseCase;
  final VerifyOtpNumber verifyOtpNumber;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;

  final _logger = Logger();


}
