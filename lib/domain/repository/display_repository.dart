import 'repository.dart';

import '../../data/mapper/response_wrapper.dart';
import '../../view/main/cubit/top_app_bar_cubit.dart';
import '../entity/menu_entity.dart';

abstract class DisplayRepository extends Repository {
  Future<ResponseWrapper<List<MenuEntity>>> getMenusByMallType({
    required TopAppBarState mallType,
  });
}
