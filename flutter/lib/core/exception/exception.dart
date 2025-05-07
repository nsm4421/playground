part of '../export.core.dart';

class CustomException implements Exception {
  final StatusCode code;
  final String message;
  final String? description;

  CustomException(
      {this.code = StatusCode.clientError,
      this.message = 'error',
      this.description});

  @override
  String toString() {
    return 'CustomException: $message';
  }
}
