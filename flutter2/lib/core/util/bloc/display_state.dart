part of 'display_bloc.dart';

class CustomDisplayState<T extends BaseEntity> {
  final Status status;
  final bool isEnd;
  late final List<T> data;
  final String errorMessage;

  CustomDisplayState(
      {this.status = Status.initial,
      this.isEnd = false,
      List<T>? data,
      this.errorMessage = ''}) {
    this.data = data ?? [];
  }

  CustomDisplayState<T> copyWith(
      {Status? status, bool? isEnd, List<T>? data, String? errorMessage}) {
    return CustomDisplayState<T>(
      status: status ?? this.status,
      isEnd: isEnd ?? this.isEnd,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  DateTime get beforeAt {
    return data.isEmpty
        ? _now
        : data
            .map((item) => item.createdAt)
            .where((item) => item != null)
            .reduce((v, e) => v!.isBefore(e!) ? v : e)!;
  }

  DateTime get _now => DateTime.now().toUtc();
}
