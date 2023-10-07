import 'package:injectable/injectable.dart';

import '../../common/utils/common.dart';
import '../../domain/model/menu_model.dart';
import '../../domain/model/view_module_model.dart';
import '../../domain/repository/display_repository.dart';
import '../data_source/remote/display_api.dart';
import '../mapper/common_mapper.dart';
import '../mapper/display_mapper.dart';
import '../mapper/response_wrapper.dart';

@Singleton(as: DisplayRepository)
class DisplayRepositoryImpl implements DisplayRepository {
  final DisplayApi _displayApi;

  DisplayRepositoryImpl(this._displayApi);

  @override
  Future<ResponseWrapper<List<MenuModel>>> getMenusByMallType({
    required MallType mallType,
  }) async {
    final response = await _displayApi.getMenusByMallType(mallType.name);
    final data = response.data?.map((dto) => dto.toModel()).toList() ?? [];

    return response.toModel<List<MenuModel>>(data);
  }

  @override
  Future<ResponseWrapper<List<ViewModuleModel>>> getViewModulesByTabIdAndPage({
    required int tabId,
    int page = 1,
  }) async {
    final response =
        await _displayApi.getViewModuleByTabIdAndPage(tabId: tabId, page: page);
    final data = response.data?.map((dto) => dto.toModel()).toList() ?? [];

    return response.toModel<List<ViewModuleModel>>(data);
  }
}
