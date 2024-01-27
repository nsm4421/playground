import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/enums/bottom_nav.enum.dart';

class BottomNavCubit extends Cubit<BottomNav> {
  BottomNavCubit() : super(BottomNav.home);

  void handleIndex(int index) => emit(BottomNav.values[index]);
}
