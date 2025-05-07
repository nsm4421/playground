part of '../export.bloc.dart';

class HomeBottomNavState {
  final HomeBottomNavItems item;
  final bool isVisible;

  HomeBottomNavState({this.item = HomeBottomNavItems.feed, this.isVisible = true});

  HomeBottomNavState copyWith({HomeBottomNavItems? item, bool? isVisible}) {
    return HomeBottomNavState(
      item: item ?? this.item,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
