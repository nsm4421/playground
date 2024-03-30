import 'package:hot_place/core/error/failure.constant.dart';

class CustomException implements Exception {
  final ErrorCode code;
  final String? message;

  CustomException({required this.code, this.message = 'error occurs'});
}
