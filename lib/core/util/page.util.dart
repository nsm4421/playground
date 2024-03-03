class CustomPageable<T> {
  final int totalCount;
  final List<T> data;

  CustomPageable({required this.totalCount, required this.data});
}
