part of '../export.core.dart';

mixin class LoggerUtil {
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 0,
    lineLength: 120,
    colors: true,
    printEmojis: true,
  ));
}
