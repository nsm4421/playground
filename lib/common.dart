/// 중요도
enum ImportanceType {
  urgent("완전 급함"), // 완전 급한
  asap("가능한 빨리"), // 가능한 빨리 (as soon as possible)
  bagOfTime("하나도 안 급함"); // 안급함

  final String _description;

  const ImportanceType(this._description);

  static getByName(String name) => ImportanceType.values
      .firstWhere((e) => e.name == name, orElse: () => ImportanceType.asap);

  static description(ImportanceType type) => type._description;
}

/// 할일 상태
enum StatusType {
  done("완료"),
  yet("하는 중");

  final String _description;

  const StatusType(this._description);

  static description(StatusType type) => type._description;

  static StatusType getOpposite(StatusType type) {
    if (type == done) return yet;
    return done;
  }
}
