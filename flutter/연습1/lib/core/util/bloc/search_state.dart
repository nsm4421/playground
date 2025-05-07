part of 'search_bloc.dart';

class CustomSearchState<T extends BaseEntity, S> extends CustomDisplayState<T> {
  final S? option;

  CustomSearchState(
      {super.status, super.isEnd, super.data, super.errorMessage, this.option});

  @override
  CustomSearchState<T, S> copyWith(
      {Status? status, bool? isEnd, List<T>? data, String? errorMessage}) {
    return CustomSearchState<T, S>(
        status: status ?? this.status,
        isEnd: isEnd ?? this.isEnd,
        data: data ?? this.data,
        errorMessage: errorMessage ?? this.errorMessage,
        option: this.option);
  }

  CustomSearchState<T, S> copyWithOption(S? option) {
    return CustomSearchState<T, S>(option: option);
  }
}
