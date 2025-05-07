enum ErrorCode {
  authError('authentication error'),
  postgrestError('database error'),
  storageError('storage error'),
  permissionError('permission denied'),
  unknownError('unknown error');

  final String description;

  const ErrorCode(this.description);
}
