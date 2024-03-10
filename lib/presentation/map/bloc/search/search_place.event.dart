import 'package:hot_place/core/constant/map.constant.dart';

class SearchPlaceEvent {}

class InitSearch extends SearchPlaceEvent {}

class SearchByCategory extends SearchPlaceEvent {
  final CategoryGroupCode category;

  SearchByCategory(this.category);
}

class SearchByCategoryAndKeyword extends SearchPlaceEvent {
  final CategoryGroupCode? category;
  final String keyword;

  SearchByCategoryAndKeyword({this.category, required this.keyword});
}
