import 'package:flutter_bloc/flutter_bloc.dart';

/// mall type
enum MallTypeState { market, beauty }

class MallTypeCubit extends Cubit<MallTypeState> {
  MallTypeCubit() : super(MallTypeState.market);

  void handleIndex(int index) => emit(MallTypeState.values[index]);
}

extension MallTypeX on MallTypeState {
  bool get isMarketMall => this == MallTypeState.market;

  bool get isBeautyMall => this == MallTypeState.beauty;

  String get mallName => this == MallTypeState.market ? 'Market' : 'Beauty';
}
