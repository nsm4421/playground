import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constant/bottom_nav.constant.dart';

@injectable
class BottomNavCubit extends Cubit<BottomNav> {
  BottomNavCubit() : super(BottomNav.home);

  void handleIndex(int index) => emit(BottomNav.values[index]);
}
