part of 'util.dart';

mixin class CustomLoggerUtil {
  final _logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true));

  Logger get logger => _logger;
}
