import 'package:flutter_bloc/flutter_bloc.dart';

enum BottomNavState { home, category, search, user }

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavState.home);

  void handleIndex(int index) => emit(BottomNavState.values[index]);
}
