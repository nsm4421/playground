import 'package:my_app/domain/usecase/base/base.usecase.dart';

import '../../repository/base.repository.dart';

abstract class RemoteUseCase<T extends Repository> extends BaseUseCase<T> {}
