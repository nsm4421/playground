import 'dart:convert';

import '../../mapper/response_wrapper.dart';
import '../../dto/display/menu_dto.dart';
import '../remote/display_api.dart';
import 'display_mock_data.dart';

class DisplayMockApi implements DisplayApi {
  @override
  Future<ResponseWrapper<List<MenuDto>>> getMenusByMallType(String mallType) =>
      Future(
        () => ResponseWrapper(
          status: 'SUCCESS',
          code: '200',
          message: 'MALL_TYPE:$mallType',
          data: jsonDecode((mallType.toUpperCase() == "MARKET")
                  ? DisplayMockData.menusByMarket
                  : DisplayMockData.menusByBeauty)
              .map(MenuDto.fromJson)
              .toList(),
        ),
      );
}
