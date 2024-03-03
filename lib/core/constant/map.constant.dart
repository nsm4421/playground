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
