part of '../export.bloc.dart';

@injectable
class HomeBottomNavCubit extends Cubit<HomeBottomNavState> {
  HomeBottomNavCubit(@factoryParam this._navigationShell)
      : super(HomeBottomNavState());

  final StatefulNavigationShell _navigationShell;

  void handleIndex(int index) {
    assert((index >= 0) && (index < HomeBottomNavItems.values.length));
    _navigationShell.goBranch(
      index,
    );
    emit(state.copyWith(item: HomeBottomNavItems.values[index]));
  }

  void handleVisibility(bool isVisible) {
    emit(state.copyWith(isVisible: isVisible));
  }
}
