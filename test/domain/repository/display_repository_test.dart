import 'package:commerce_app/data/data_source/mock/display_mock_api.dart';
import 'package:commerce_app/data/data_source/remote/display_api.dart';
import 'package:commerce_app/data/dto/display/menu_dto.dart';
import 'package:commerce_app/data/mapper/common_mapper.dart';
import 'package:commerce_app/data/mapper/display_mapper.dart';
import 'package:commerce_app/data/mapper/response_wrapper.dart';
import 'package:commerce_app/data/repository_impl/display_repository_impl.dart';
import 'package:commerce_app/domain/model/menu_model.dart';
import 'package:commerce_app/domain/repository/display_repository.dart';
import 'package:commerce_app/view/main/cubit/top_app_bar_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDisplayApi extends Mock implements DisplayApi {}

void main() {
  late DisplayRepository sut; // system under test
  late DisplayApi displayApi;

  setUpAll(() {
    displayApi = MockDisplayApi();
    sut = DisplayRepositoryImpl(displayApi);
  });

  test('의존성 주입 테스트', () => expect(sut, isNotNull));

  group('Display', () {
    test('Repository 메써드 호출 시, API가 1번 호출됨', () async {
      // when repository method called
      try {
        await sut.getMenusByMallType(
            mallType: MallTypeState.market);
      } catch (e) {}
      verify(() => displayApi.getMenusByMallType(any())).called(1);
    });

    test('API가 실패하는 경우, Repository 메써드 호출 실패', () async {
      final e = Exception('API Call Failed');
      when(() => displayApi.getMenusByMallType(any())).thenThrow(e);
      expect(
          () => sut.getMenusByMallType(
              mallType: MallTypeState.market),
          throwsA(e));
    });

    test('API가 성공적하는 경우, 응답 데이터 확인', () async {
      final ResponseWrapper<List<MenuDto>> mockResponse =
          await DisplayMockApi().getMenusByMallType(MallTypeState.market.name);
      when(() => displayApi.getMenusByMallType(any()))
          .thenAnswer((_) async => mockResponse);
      final actual = await sut.getMenusByMallType(
          mallType: MallTypeState.market);
      final ResponseWrapper<List<MenuModel>> expected =
          mockResponse.toModel<List<MenuModel>>(
              mockResponse.data?.map((dto) => dto.toModel()).toList() ?? []);
      expect(actual, expected);
    });
  });
}
