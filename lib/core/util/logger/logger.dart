import 'package:logger/logger.dart';

mixin class CustomLogger {
  final _logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true));

  Logger get logger => _logger;
}
