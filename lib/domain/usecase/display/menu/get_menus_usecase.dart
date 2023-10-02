import 'package:commerce_app/domain/model/result.dart';

import '../../../../common/utils/common.dart';
import '../../../../common/utils/error/error_response.dart';
import '../../../repository/display_repository.dart';
import '../../base/remote_usecase.dart';

class GetMenusUseCase extends RemoteUseCase<DisplayRepository> {
  final MallType mallType;

  GetMenusUseCase(this.mallType);

  @override
  Future call(DisplayRepository repository) async {
    final result = await repository.getMenusByMallType(mallType: mallType);

    return result.status == 'SUCCESS'
        ? Result.success(result.data ?? [])
        : Result.failure(
            ErrorResponse(
              status: result.status,
              code: result.code,
              message: result.message,
            ),
          );
  }
}
