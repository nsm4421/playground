part of 'constant.dart';

enum ErrorCode {
  auth('authentication error'),
  db('database error'),
  storage('storage error'),
  network('network error'),
  unknownError('unknown error');

  final String description;

  const ErrorCode(this.description);
}
