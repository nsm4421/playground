import 'dart:convert';

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

  _parseMenus(String source) {
    final List json = jsonDecode(source);
    List<MenuDto> menus = [];
    menus = json.map((e) => MenuDto.fromJson(e)).toList();

    return menus;
  }
}
