import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav.dart';

class BottomNavCubit extends Cubit<BottomNav> {
  BottomNavCubit() : super(BottomNav.home);

  void handleSelect(int index) {
    emit(BottomNav.values[index]);
  }
}
