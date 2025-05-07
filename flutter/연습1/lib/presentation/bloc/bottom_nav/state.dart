part of 'cubit.dart';

class HomeBottomNavState {
  late final HomeBottomNavItem current;
  final bool visible;

  HomeBottomNavState({HomeBottomNavItem? current, this.visible = true}) {
    this.current = current ?? HomeBottomNavItem.values.first;
  }

  HomeBottomNavState copyWith({HomeBottomNavItem? current, bool? visible}) {
    return HomeBottomNavState(
        current: current ?? this.current, visible: visible ?? this.visible);
  }
}
