import '../constant/error_code.dart';

class Failure {
  final ErrorCode code;
  final String? message;

  Failure({required this.code, this.message});
}