import '../constant/constant.dart';

class CustomException implements Exception {
  final String message;
  final ErrorCode code;

  CustomException(this.code, {this.message = 'custom exception'});

  @override
  String toString() => 'CustomException: $message';

  factory CustomException.from(Exception exception) {
    // 에러 유형별 코드 세분화하기
    return CustomException(ErrorCode.unknownError,
        message: exception.toString());
  }
}
