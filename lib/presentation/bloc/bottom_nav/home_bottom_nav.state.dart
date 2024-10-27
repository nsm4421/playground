part of 'home_bottom_nav.cubit.dart';

class HomeBottomNavState {
  final bool visible;
  final HomeBottomNavItems current;

  HomeBottomNavState({required this.visible, required this.current});

  HomeBottomNavState copyWith({bool? visible, HomeBottomNavItems? current}) {
    return HomeBottomNavState(
        visible: visible ?? this.visible, current: current ?? this.current);
  }
}
