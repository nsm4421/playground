part of 'constant.dart';

class CustomDisplayState<T extends BaseEntity> {
  final Status status;
  final bool isFetching;
  final bool isEnd;
  late final List<T> data;
  final String errorMessage;

  CustomDisplayState(
      {this.status = Status.initial,
      this.isFetching = false,
      this.isEnd = false,
      List<T>? data,
      this.errorMessage = ''}) {
    this.data = data ?? [];
  }

  CustomDisplayState<T> copyWith(
      {Status? status,
      bool? isFetching,
      bool? isEnd,
      List<T>? data,
      DateTime? beforeAt,
      String? errorMessage}) {
    return CustomDisplayState<T>(
        status: status ?? this.status,
        isFetching: isFetching ?? this.isFetching,
        isEnd: isEnd ?? this.isEnd,
        data: data ?? this.data,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  // created_at필드가 beforeAt보다 작은 레코드만 fetch하기 위한 필드
  String get beforeAt {
    final now = customUtil.now;
    try {
      return data.isEmpty
          ? now
          : data
              .map((item) => item.createdAt)
              .where((item) => item != null)
              .reduce((v, e) => v!.isBefore(e!) ? v : e)!
              .toIso8601String();
    } catch (error) {
      customUtil.logger.e(error);
      return now;
    }
  }

  CustomDisplayState<T> from(Either<ErrorResponse, List<T>> res,
      {int take = 20}) {
    return res.fold((l) {
      return this.copyWith(
          status: Status.error, isFetching: false, errorMessage: l.message);
    }, (r) {
      return this.copyWith(
          status: Status.success,
          isFetching: false,
          isEnd: take > data.length,
          data: [...this.data, ...r]);
    });
  }
}
