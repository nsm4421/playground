import 'package:injectable/injectable.dart';

import 'mock/display_mock_api.dart';
import 'remote/display_api.dart';

@module
abstract class DataSourceModule {
  @singleton
  DisplayApi get displayApi => DisplayMockApi();
}
