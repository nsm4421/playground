class KakaoApiResponseWrapper<T> {
  final int totalCount;
  final List<T> data;

  KakaoApiResponseWrapper({required this.totalCount, required this.data});
}
