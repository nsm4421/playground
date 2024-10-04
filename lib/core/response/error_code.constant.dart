enum ErrorType {
  /// auth
  auth(description: 'authentication error', code: 1000),
  // 로그인
  invalidCredential(description: '잘못된 이메일 또는 비밀번호로 로그인 시도 시 발생', code: 1001),
  emailNotConfirmed(description: '사용자가 이메일 인증을 완료하지 않은 경우 발생', code: 1002),
  userNotFound(description: '입력한 이메일에 해당하는 사용자가 없는 경우', code: 1003),
  inCorrectPassword(description: '비밀번호가 틀렸을 때 발생', code: 1004),
  accountDisabled(description: '사용자의 계정이 비활성화된 경우 발생', code: 1005),
  invalidExpiredToken(description: '사용자의 인증 토큰이 잘못되었거나 만료된 경우 발생', code: 1006),
  // 회원가입
  userAlreadyExist(code: 1007),
  invalidFormat(description: '잘못된 이메일 형식', code: 1008),
  toWeekPassword(description: '비밀번호가 너무 약함', code: 1009),

  /// remote db
  db(description: 'database error', code: 2000),

  /// hive error
  localDb(description: 'database error', code: 3000),

  /// storage
  storage(description: 'storage error', code: 4000),

  /// network
  network(description: 'network error', code: 5000),

  /// else
  unknownError(description: 'unknown error', code: 9999);

  final String? description;
  final int? code;

  const ErrorType({this.description, this.code});
}
