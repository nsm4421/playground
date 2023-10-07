import 'dart:convert';

import '../../dto/display/view_module_dto.dart';
import '../../mapper/response_wrapper.dart';
import '../../dto/display/menu_dto.dart';
import '../remote/display_api.dart';
import 'display_mock_data.dart';

class DisplayMockApi implements DisplayApi {
  @override
  Future<ResponseWrapper<List<MenuDto>>> getMenusByMallType(String mallType) =>
      Future(
        () => ResponseWrapper<List<MenuDto>>(
          status: 'SUCCESS',
          code: '200',
          message: 'MALL_TYPE:$mallType',
          data: _parseMenus(
            (mallType.toUpperCase() == "MARKET")
                ? DisplayMockData.menusByMarket
                : DisplayMockData.menusByBeauty,
          ),
        ),
      );

  @override
  Future<ResponseWrapper<List<ViewModuleDto>>> getViewModuleByTabIdAndPage({
    required int tabId,
    int page = 1,
  }) async {
    // 최대 4p 까지
    final int max_page = 4;

    if (page >= max_page)
      return Future(() => ResponseWrapper(
            status: 'SUCCESS',
            code: '200',
            message: 'NOTHING TO RETURN',
            data: null,
          ));

    String source = DisplayMockData.getViewModules();
    final data = _parseViewModules(source);

    return Future(() => ResponseWrapper(
          status: 'SUCCESS',
          code: '200',
          message: 'MENU',
          data: data,
        ));
  }

  _parseMenus(String source) {
    final List json = jsonDecode(source);
    List<MenuDto> menus = [];
    menus = json.map((e) => MenuDto.fromJson(e)).toList();

    return menus;
  }

  _parseViewModules(String source) {
    final List json = jsonDecode(source);
    List<ViewModuleDto> result = [];
    result = json.map((e) => ViewModuleDto.fromJson(e)).toList();

    return result;
  }
}
