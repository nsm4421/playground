import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double _iconSize = 23;
const double _activeIconSize = 28;

enum BottomNavigationItem {
  feed(
      icon: Icon(Icons.home_outlined, size: _iconSize),
      activeIcon: Icon(Icons.home, size: _activeIconSize),
      label: 'Feed'),
  search(
      icon: Icon(Icons.search, size: _iconSize),
      activeIcon: Icon(Icons.search_rounded, size: _activeIconSize),
      label: 'Search'),
  post(
      icon: Icon(Icons.add, size: _iconSize),
      activeIcon: Icon(Icons.add, size: _activeIconSize),
      label: 'Post'),
  favorite(
      icon: Icon(Icons.favorite_outline, size: _iconSize),
      activeIcon: Icon(Icons.favorite, size: _activeIconSize),
      label: 'Post'),
  profile(
      icon: Icon(Icons.account_circle_outlined, size: _iconSize),
      activeIcon: Icon(Icons.account_circle, size: _activeIconSize),
      label: 'Profile');

  const BottomNavigationItem(
      {required this.icon, required this.activeIcon, required this.label});

  final Icon icon;
  final Icon activeIcon;
  final String label;
}

class BottomNavigationCubit extends Cubit<BottomNavigationItem> {
  BottomNavigationCubit() : super(BottomNavigationItem.feed);

  void handleIndex(int index) => emit(BottomNavigationItem.values[index]);
}
