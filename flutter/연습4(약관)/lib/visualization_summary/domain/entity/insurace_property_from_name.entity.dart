class InsurancePropertyFromName {
  final String keyword;
  final String description;

  InsurancePropertyFromName({required this.keyword, required this.description});

  InsurancePropertyFromName copyWith({String? keyword, String? description}) {
    return InsurancePropertyFromName(
      keyword: keyword ?? this.keyword,
      description: description ?? this.description,
    );
  }
}

final List<InsurancePropertyFromName> initialInsurancePropertiesFromName = [
  InsurancePropertyFromName(keyword: '무배당', description: '계약자에게 배당하지 않는 상품입니다'),
  InsurancePropertyFromName(
    keyword: '유배당',
    description: '계약자에게 배당을 지급하는 상품입니다',
  ),
  InsurancePropertyFromName(
    keyword: '단체',
    description: '다수로 구성된 피보험자 그룹을 대상으로 하는 상품입니다',
  ),
  InsurancePropertyFromName(
    keyword: '어린이',
    description: '0세부터 15세까지 가입가능한 상품입니다',
  ),
  InsurancePropertyFromName(
    keyword: '간편',
    description: '일반 상품 대비 간편한 심사절차를 통해 가입할 수 있는 상품입니다',
  ),
  InsurancePropertyFromName(
    keyword: '건강',
    description: '상해,질병으로 인한 진단,입원,수술 등의 위험을 보장하는 상품입니다',
  ),
  InsurancePropertyFromName(
    keyword: '암보험',
    description: '암 진단 위험을 보장받을 수 있는 상품입니다',
  ),
  InsurancePropertyFromName(
    keyword: '치아보험',
    description: '치아관련 위험을 보장하는 상품입니다',
  ),
  InsurancePropertyFromName(
    keyword: 'MY바이크',
    description: '이륜자동차사고와 관련된 사망/후유장해 및 각종 비용손해를 보장하는 보헙입니다',
  ),
  InsurancePropertyFromName(
    keyword: '재물보험',
    description: '화재,도난,폭발 등의 재물손해를 보장하는 상품입니다',
  ),
  InsurancePropertyFromName(
    keyword: '종합보험',
    description: '신체,비용손해 등 중 두 가지 이상의 손해를 종합적으로 보장하는 보험입니다',
  ),
  InsurancePropertyFromName(
    keyword: '펫퍼민트Puppy',
    description: '반려견의 통원,입원 등의 위험을 보장하는 상품입니다',
  ),
  InsurancePropertyFromName(
    keyword: '펫퍼민트Cat',
    description: '반려묘의 통원,입원 등의 위험을 보장하는 상품입니다',
  ),
  InsurancePropertyFromName(
    keyword: '실손의료비',
    description: '피보험자의 질병 또는 상해로 인한 손해(의료비에 한정합니다)를 보장하는 실손보상하는 상품입니다',
  ),
  InsurancePropertyFromName(
    keyword: '저축',
    description: '공시이율에 따라 적립하여 만기에 지급하는 상품입니다',
  ),
  InsurancePropertyFromName(
    keyword: '정기',
    description: '일정한 보험기간동안 사망을 보장하는 상품입니다',
  ),
];
