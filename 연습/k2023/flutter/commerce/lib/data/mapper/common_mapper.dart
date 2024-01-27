import 'response_wrapper.dart';

extension ResponseWrapperX on ResponseWrapper {
  ResponseWrapper<T> toModel<T>(T data) => ResponseWrapper<T>(
        status: status,
        code: code,
        message: message,
        data: data,
      );
}
