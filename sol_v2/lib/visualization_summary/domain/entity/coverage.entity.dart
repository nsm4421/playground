class Coverage {
  final String category; // 담보구분
  final String coverageName; // 담보명
  final String policyLimit; // 보장한도
  final String deductible; // 자기부담금
  final bool indemnity; // 실손보상여부

  Coverage({
    required this.category,
    required this.coverageName,
    this.policyLimit = '',
    this.deductible = '',
    this.indemnity = false,
  });

  Coverage copyWith({
    String? category,
    String? coverageName,
    String? policyLimit,
    String? deductible,
    bool? indemnity,
  }) {
    return Coverage(
      category: category ?? this.category,
      coverageName: coverageName ?? this.coverageName,
      policyLimit: policyLimit ?? this.policyLimit,
      deductible: deductible ?? this.deductible,
      indemnity: indemnity ?? this.indemnity,
    );
  }
}

final List<Coverage> initialCoverages = [
  Coverage(
    category: '상해',
    coverageName: '일반상입원일당',
    policyLimit: '최초입원일부터 1회 입원당 180일한도 보장',
  ),
  Coverage(category: '비용', coverageName: '벌금(대인)', indemnity: true),
  Coverage(
    category: '비용',
    coverageName: '갱신형 가족일상생활배상책임3',
    deductible: "1사고당 자기부담금: 대인-없음 / 대물-누수50만원 이외 20만원",
  ),
  Coverage(category: '비용', coverageName: '신8대가전제품수리비용', deductible: "1사고당 2만원"),
  Coverage(category: '질병', coverageName: '암진단비(유사암제외)'),
  Coverage(
    category: '질병',
    coverageName: '치아보존치료비(크라운 연간3회한)',
    policyLimit: "연간 3개에 한해 보장(크라운 치료에 한함)",
  ),
];
