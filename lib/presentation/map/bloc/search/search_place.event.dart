import 'package:hot_place/core/constant/map.constant.dart';

class SearchPlaceEvent {}

class InitSearch extends SearchPlaceEvent {}

class SearchByCategory extends SearchPlaceEvent {
  final CategoryGroupCode category;
  final int? radius;

  SearchByCategory({required this.category, this.radius});
}

class SearchByCategoryAndKeyword extends SearchPlaceEvent {
  final CategoryGroupCode? category;
  final String keyword;
  final int? radius;

  SearchByCategoryAndKeyword(
      {this.category, required this.keyword, this.radius});
}
