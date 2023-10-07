import 'package:injectable/injectable.dart';

import '../../repository/display_repository.dart';
import '../base/remote_usecase.dart';

@singleton
class DisplayUseCase {
  final DisplayRepository _displayRepository;

  DisplayUseCase(this._displayRepository);

  Future execute<T>({required RemoteUseCase remoteUseCase}) async =>
      await remoteUseCase(_displayRepository);
}
