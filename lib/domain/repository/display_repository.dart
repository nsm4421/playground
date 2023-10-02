import '../model/menu_model.dart';
import 'repository.dart';

import '../../data/mapper/response_wrapper.dart';
import '../../view/main/cubit/top_app_bar_cubit.dart';

abstract class DisplayRepository extends Repository {
  Future<ResponseWrapper<List<MenuModel>>> getMenusByMallType({
    required MallTypeState mallType,
  });
}
