class ResponseWrapper<T> {
  final bool ok;
  final T? data;
  final String? message;

  ResponseWrapper._({required this.ok, this.data, this.message});

  factory ResponseWrapper.success(T data) {
    return ResponseWrapper._(ok: true, data: data);
  }

  factory ResponseWrapper.error(String? message) {
    return ResponseWrapper._(ok: false, message: message ?? "ERROR");
  }
}
