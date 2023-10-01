import 'package:flutter_bloc/flutter_bloc.dart';

/// mall type
enum TopAppBarState { market, beauty }

class TopAppBarCubit extends Cubit<TopAppBarState> {
  TopAppBarCubit() : super(TopAppBarState.market);

  void handleIndex(int index) => emit(TopAppBarState.values[index]);
}

extension TopAppBarCubitX on TopAppBarState {
  bool get isMarketMall => this == TopAppBarState.market;

  bool get isBeautyMall => this == TopAppBarState.beauty;

  String get mallName => this == TopAppBarState.market ? 'Market' : 'Beauty';
}
