import 'package:commerce_app/common/utils/common.dart';
import 'package:commerce_app/common/utils/error/error_response.dart';
import 'package:commerce_app/data/data_source/remote/display_api.dart';
import 'package:commerce_app/data/repository_impl/display_repository_impl.dart';
import 'package:commerce_app/domain/model/menu_model.dart';
import 'package:commerce_app/domain/model/result.dart';
import 'package:commerce_app/domain/repository/display_repository.dart';
import 'package:commerce_app/domain/usecase/display/display_usecase.dart';
import 'package:commerce_app/domain/usecase/display/menu/get_menus_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDisplayApi extends Mock implements DisplayApi {}

class MockDisplayRepository extends Mock implements DisplayRepository {}

class MockRemoteUseCase extends Mock implements GetMenusUseCase {}

void main() {
  late DisplayRepository displayRepository;
  late DisplayUseCase sut;

  setUpAll(() {
    displayRepository = DisplayRepositoryImpl(MockDisplayApi());
    sut = DisplayUseCase(displayRepository);
  });

  test('의존성 주입 테스트', () => expect(sut, isNotNull));

  test('메뉴 목록 불러오기', () async {
    final remoteUseCase = MockRemoteUseCase();
    final expected = Result.success([MenuModel(title: 'test title', tabId: 1)]);
    when(() => remoteUseCase.mallType).thenReturn(MallType.market);
    when(() => remoteUseCase.call(displayRepository))
        .thenAnswer((_) async => expected);
    final actual = await sut.execute(remoteUseCase: remoteUseCase);
    expect(actual, expected);
  });

  test('메뉴 목록 불러오기 실패', () async {
    final remoteUseCase = MockRemoteUseCase();
    final expected =
        Result<List<MenuModel>>.failure(ErrorResponse(status: 'error'));
    when(() => remoteUseCase.mallType).thenReturn(MallType.market);
    when(() => remoteUseCase.call(displayRepository))
        .thenAnswer((_) async => expected);
    final actual = await sut.execute(remoteUseCase: remoteUseCase);
    expect(actual, expected);
  });
}
