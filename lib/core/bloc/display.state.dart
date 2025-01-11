part of '../export.core.dart';

class DisplayState<T extends Entity> extends Pageable<T> {
  final Status status;
  final bool isMounted;
  final bool isEnd;
  final String message;

  DisplayState({
    super.data,
    super.totalCount,
    super.pageSize,
    super.currentPage,
    super.totalPages,
    this.status = Status.initial,
    this.isMounted = false,
    this.isEnd = false,
    this.message = '',
  });

  @override
  DisplayState<T> copyWith({
    List<T>? data,
    int? totalCount,
    int? pageSize,
    int? currentPage,
    int? totalPages,
    Status? status,
    bool? isMounted,
    bool? isEnd,
    String? message,
  }) {
    return DisplayState(
      data: data ?? this.data,
      totalCount: totalCount ?? this.totalCount,
      pageSize: pageSize ?? this.pageSize,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalCount ?? this.totalCount,
      status: status ?? this.status,
      isMounted: isMounted ?? this.isMounted,
      isEnd: isEnd ?? this.isEnd,
      message: message ?? this.message,
    );
  }

  DisplayState<T> from(Pageable<T> pageable) {
    return DisplayState<T>(
      data: pageable.data,
      totalCount: pageable.totalCount,
      pageSize: pageable.pageSize,
      currentPage: pageable.currentPage,
      totalPages: pageable.totalPages,
      status: status,
      isMounted: isMounted,
      isEnd: isEnd,
      message: message,
    );
  }
}
