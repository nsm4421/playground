part of 'feed.dart';

class SearchFeedOption {
  final FeedSearchFields searchField;
  final String searchText;

  SearchFeedOption({
    required this.searchField,
    required this.searchText,
  });

  SearchFeedOption copyWith(
      {FeedSearchFields? searchField, String? searchText}) {
    return SearchFeedOption(
        searchField: searchField ?? this.searchField,
        searchText: searchText ?? this.searchText);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is! SearchFeedOption) {
      return false;
    } else {
      return other.searchField == searchField && other.searchText == searchText;
    }
  }

  @override
  int get hashCode => Object.hash(searchField, searchText);
}
