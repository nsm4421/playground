import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/constant.dart';

part 'home_bottom_nav.state.dart';

class HomeBottomNavCubit extends Cubit<HomeBottomNavState> {
  HomeBottomNavCubit()
      : super(HomeBottomNavState(
            visible: true, current: HomeBottomNavItems.values.first));

  void handleChange(int index) {
    emit(state.copyWith(current: HomeBottomNavItems.values[index]));
  }

  void handleVisible(bool visible) {
    emit(state.copyWith(visible: visible));
  }
}
