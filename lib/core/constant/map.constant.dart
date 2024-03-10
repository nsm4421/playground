enum AddressType {
  REGION("지명"),
  ROAD("도로명"),
  REGION_ADDR("지번 주소"),
  ROAD_ADDR("도로명 주소");

  final String description;

  const AddressType(this.description);
}

enum MapYN {
  Y("YES"),
  N("NO");

  final String description;

  const MapYN(this.description);
}

// https://developers.kakao.com/docs/latest/ko/local/dev-guide#search-by-category-request-query-category-group-code
enum CategoryGroupCode {
  MT1("대형마트"),
  CS2("편의점"),
  PS3("어린이집, 유치원"),
  SC4("학교"),
  AC5("학원"),
  PK6("주차장"),
  OL7("주유소, 충전소"),
  SW8("지하철역"),
  BK9("은행"),
  CT1("문화시설"),
  AG2("중개업소"),
  PO3("공공기관"),
  AT4("관광명소"),
  AD5("숙박"),
  FD6("음식점"),
  CE7("카페"),
  HP8("병원"),
  PM9("약국");

  final String description;

  const CategoryGroupCode(this.description);
}