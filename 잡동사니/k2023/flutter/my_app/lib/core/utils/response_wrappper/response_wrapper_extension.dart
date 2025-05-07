import 'package:my_app/core/utils/response_wrappper/response_wrapper.dart';

extension ResponseWrapperEx on ResponseWrapper {
  ResponseWrapper<T> toModel<T>(T data) => ResponseWrapper<T>(
      status: status, message: message, code: code, data: data);
}
