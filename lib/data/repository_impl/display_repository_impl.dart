import '../../domain/model/menu_model.dart';
import '../../domain/repository/display_repository.dart';
import '../../view/main/cubit/top_app_bar_cubit.dart';
import '../data_source/remote/display_api.dart';
import '../mapper/common_mapper.dart';
import '../mapper/display_mapper.dart';
import '../mapper/response_wrapper.dart';

class DisplayRepositoryImpl implements DisplayRepository {
  final DisplayApi _displayApi;

  DisplayRepositoryImpl(this._displayApi);

  @override
  Future<ResponseWrapper<List<MenuModel>>> getMenusByMallType({
    required MallTypeState mallType,
  }) async {
    final response = await _displayApi.getMenusByMallType(mallType.name);
    final data = response.data?.map((dto) => dto.toModel()).toList() ?? [];

    return response.toEntity<List<MenuModel>>(data);
  }
}
