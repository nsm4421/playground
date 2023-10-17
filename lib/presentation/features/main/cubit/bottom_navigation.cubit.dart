import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/bottom_navigation.enum.dart';

class BottomNavCubit extends Cubit<BottomNavigation> {
  BottomNavCubit() : super(BottomNavigation.home);

  void handleIndex(int index) => emit(BottomNavigation.values[index]);
}
