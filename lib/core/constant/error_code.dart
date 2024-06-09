enum ErrorCode {
  internalServerError("INTERNAL_SERVER_ERROR"),
  notSignIn("NOT_SIGN_IN"),
  notGranted("NOT_GRANTED"),
  notFound('NOT_FOUND'),
  authError("AUTH_ERROR"),
  invalidArgs("INVALID_ARGUMENTS"),
  firebaseAuthException("FIREBASE_AUTH_ERROR"),
  duplicatedEntity("DUPLICATED_ENTITY"),
  unKnownError("UNKNOWN_ERROR"),
  ;

  final String name;

  const ErrorCode(this.name);
}
