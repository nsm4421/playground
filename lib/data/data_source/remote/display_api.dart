import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../dto/display/view_module.dart';
import '../../mapper/response_wrapper.dart';
import '../../dto/display/menu_dto.dart';

part '../../../generated/display_api.g.dart';

@RestApi()
abstract class DisplayApi {
  factory DisplayApi(Dio dio, {String baseUrl}) = _DisplayApi;

  @GET("/api/menu/{mall_type}")
  Future<ResponseWrapper<List<MenuDto>>> getMenusByMallType(
    @Path('mall_type') String mallType,
  );

  @GET("/api/view-modules/{tab_id}")
  Future<ResponseWrapper<List<ViewModuleDto>>> getViewModuleByTabIdAndPage({
    @Path('tab_id') required int tabId,
    @Query('page') int page = 1,
  });
}
