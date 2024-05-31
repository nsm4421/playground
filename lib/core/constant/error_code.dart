enum ErrorCode {
  internalServerError("INTERNAL_SERVER_ERROR"),
  notSignIn("NOT_SIGN_IN"),
  notGranted("NOT_GRANTED"),
  notFound('NOT_FOUND'),
  // bad request
  invalidArgs("INVALID_ARGUMENT"),
  // firebase
  firebaseAuthException("FIREBASE_AUTH_ERROR"),
  firebasePermissionDenied("FIREBASE_PERMISSION_DENIED"),
  firebaseAlreadyExists("FIREBASE_ALREADY_EXISTS"),
  firebaseUnavailable("FIREBASE_UNAVAILABLE"),
  firebaseNotFound("FIREBASE_NOT_FOUND"),
  firebaseUnKnown("FIREBASE_UNKNOWN_ERROR"),
  // else
  unKnownError("UNKNOWN_ERROR"),
  ;

  final String name;

  const ErrorCode(this.name);
}
