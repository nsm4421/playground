import 'package:hot_place/core/constant/map.constant.dart';

class CategoryEvent {}

class InitCategory extends CategoryEvent {}

class CategoryChanged extends CategoryEvent {
  final CategoryGroupCode category;

  CategoryChanged(this.category);
}
