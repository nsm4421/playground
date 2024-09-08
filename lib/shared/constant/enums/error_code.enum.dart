enum ErrorCode {
  authError('authentication error'),
  postgrestError('database error'),
  storageError('storage error'),
  unknownError('unknown error');

  final String description;

  const ErrorCode(this.description);
}
