enum Status {
  initial,
  loading,
  success,
  error;
}

class KakaoApiResponseMapper<T> {
  final _Meta _meta;
  final Iterable<T> _documents;

  KakaoApiResponseMapper({required meta, required Iterable<T> documents})
      : _meta = meta,
        _documents = documents;

  _Meta get meta => _meta;

  Iterable<T> get documents => _documents;

  factory KakaoApiResponseMapper.fromResponse(res) => KakaoApiResponseMapper<T>(
      meta: res.data['meta'],
      documents: (res.data['documents'] as Iterable<T>));

  KakaoApiResponseMapper<T> take(int count) =>
      KakaoApiResponseMapper<T>(meta: _meta, documents: _documents.take(count));
}

class _Meta {
  final int? total_count;

  _Meta(this.total_count);
}
