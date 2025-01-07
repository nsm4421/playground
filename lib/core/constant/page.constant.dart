part of '../export.core.dart';

class Pageable<T> {
  late final List<T> data;
  final int totalCount;
  final int pageSize;
  final int currentPage;
  final int totalPages;

  Pageable(
      {List<T>? data,
      this.totalCount = 0,
      this.pageSize = 0,
      this.currentPage = 0,
      this.totalPages = 0}) {
    this.data = data ?? [];
  }

  factory Pageable.fromJson(
      {required Map<String, dynamic> json,
      required T Function(Map<String, dynamic> json) callback}) {
    return Pageable<T>(
        totalCount: json['totalCount'] as int,
        pageSize: json['pageSize'] as int,
        currentPage: json['currentPage'] as int,
        totalPages: json['totalPages'] as int,
        data: (json['data'] as List<dynamic>)
            .map((item) => callback(item))
            .toList());
  }

  Pageable<T> copyWith(
      {List<T>? data,
      int? totalCount,
      int? pageSize,
      int? currentPage,
      int? totalPages}) {
    return Pageable<T>(
      data: data ?? this.data,
      totalCount: totalCount ?? this.totalCount,
      pageSize: pageSize ?? this.pageSize,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalCount ?? this.totalCount,
    );
  }

  // type casting of data
  Pageable<S> convert<S>(S Function(T item) callback) {
    return Pageable<S>(
      data: data.map(callback).toList(),
      totalCount: totalCount,
      pageSize: pageSize,
      currentPage: currentPage,
      totalPages: totalCount,
    );
  }
}
