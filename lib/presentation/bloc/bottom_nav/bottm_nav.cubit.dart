import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part '../../../core/constant/bottom_nav.dart';

@injectable
class BottomNavCubit extends Cubit<BottomNav> {
  BottomNavCubit() : super(BottomNav.home);

  handleIndex(int index) => emit(BottomNav.values[index]);
}
