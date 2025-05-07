import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/constant/constant.dart';

part 'state.dart';

class HomeBottomNavCubit extends Cubit<HomeBottomNavState> {
  HomeBottomNavCubit() : super(HomeBottomNavState());

  handleIndex(int index) {
    emit(state.copyWith(current: HomeBottomNavItem.values[index]));
  }

  switchVisible(bool visible) {
    emit(state.copyWith(visible: visible));
  }
}
