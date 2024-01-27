import 'package:get_it/get_it.dart';

import 'package:injectable/injectable.dart';
import 'generated/dependency_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
