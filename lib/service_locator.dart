import 'domain/repository/display_repository.dart';
import 'package:get_it/get_it.dart';

import 'data/data_source/mock/display_mock_api.dart';
import 'data/data_source/remote/display_api.dart';
import 'data/repository_impl/display_repository_impl.dart';
import 'domain/usecase/display/display_usecase.dart';

final locator = GetIt.instance;

void setLocator() {
  _data();
  _domain();
}

void _data() {
  locator.registerSingleton<DisplayApi>(DisplayMockApi());
}

void _domain() {
  locator.registerSingleton<DisplayRepository>(
    DisplayRepositoryImpl(locator<DisplayApi>()),
  );
  locator.registerSingleton<DisplayUseCase>(
    DisplayUseCase(locator<DisplayRepository>()),
  );
}
