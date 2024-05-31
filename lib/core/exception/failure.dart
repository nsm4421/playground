import 'package:my_app/core/exception/custom_exeption.dart';

import '../constant/error_code.dart';

class Failure {
  final ErrorCode code;
  final String? message;

  Failure({required this.code, this.message});

  CustomException toCustomException() =>
      CustomException(errorCode: code, message: message);
}
