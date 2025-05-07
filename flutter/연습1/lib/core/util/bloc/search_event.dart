part of 'search_bloc.dart';

@sealed
class CustomSearchEvent<T extends BaseEntity, S>
    extends CustomDisplayEvent<T> {}

class InitSearchEvent<T extends BaseEntity, S> extends CustomSearchEvent<T, S> {
  final Status? status;
  final List<T>? data;
  final String? errorMessage;

  InitSearchEvent({this.status, this.data, this.errorMessage});
}

class SearchOptionEditedEvent<T extends BaseEntity, S>
    extends CustomSearchEvent<T, S> {
  final S? option;

  SearchOptionEditedEvent(this.option);
}

class ClearSearchOptionEvent<T extends BaseEntity, S>
    extends CustomSearchEvent<T, S> {
  ClearSearchOptionEvent();
}

class FetchEvent<T extends BaseEntity, S> extends CustomSearchEvent<T, S> {
  final bool refresh;
  final int take;

  FetchEvent({this.refresh = false, this.take = 20});
}
