import '../../common/utils/common.dart';
import '../model/menu_model.dart';
import 'repository.dart';

import '../../data/mapper/response_wrapper.dart';

abstract class DisplayRepository extends Repository {
  Future<ResponseWrapper<List<MenuModel>>> getMenusByMallType({
    required MallType mallType,
  });
}
