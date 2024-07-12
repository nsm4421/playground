enum KakaoMapApiEndPoint {
  getAddressFromCoordinate(
      'https://dapi.kakao.com/v2/local/geo/coord2address.json',
      description: '현재 좌표를 주면, 주소 반환');

  final String endPoint;
  final String? description;

  const KakaoMapApiEndPoint(this.endPoint, {String? this.description});
}
