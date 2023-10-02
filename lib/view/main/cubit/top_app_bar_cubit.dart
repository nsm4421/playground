import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/common.dart';



class MallTypeCubit extends Cubit<MallType> {
  MallTypeCubit() : super(MallType.market);

  void handleIndex(int index) => emit(MallType.values[index]);
}

extension MallTypeX on MallType {
  bool get isMarketMall => this == MallType.market;

  bool get isBeautyMall => this == MallType.beauty;

  String get mallName => this == MallType.market ? 'Market' : 'Beauty';
}
