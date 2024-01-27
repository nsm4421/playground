import '../../../../core/constant/feed.enum.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class InitSearchEvent extends SearchEvent {}

class SearchFeedEvent extends SearchEvent {
  final SearchOption? option;
  final String? keyword;

  SearchFeedEvent({this.option, this.keyword});
}

class SearchUserEvent extends SearchEvent {
  final String? keyword;

  SearchUserEvent({this.keyword});
}
