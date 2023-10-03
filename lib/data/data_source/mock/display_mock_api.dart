import 'dart:convert';

import '../../dto/display/view_module.dart';
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
  Future<ResponseWrapper<List<ViewModuleDto>>> getViewModuleByTabId(
    int tabId,
  ) async {
    late String source;
    final endOfTabId = tabId % 10;
    switch (endOfTabId) {
      case 1:
        source = DisplayMockData.viewModulesByTabIdCaseOne;
      case 2:
        source = DisplayMockData.viewModulesByTabIdCaseTwo;
      case 3:
        source = DisplayMockData.viewModulesByTabIdCaseThree;
      case 4:
        source = DisplayMockData.viewModulesByTabIdCaseFour;
      case 5:
        source = DisplayMockData.viewModulesByTabIdCaseFive;
    }
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
