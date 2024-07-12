import 'package:my_app/core/exception/custom_exception.dart';

import '../constant/error_code.dart';

class Failure {
  final ErrorCode code;
  final String? message;

  Failure({required this.code, this.message});

  CustomException toCustomException({String? message}) =>
      CustomException(errorCode: code, message: message ?? message);
}
