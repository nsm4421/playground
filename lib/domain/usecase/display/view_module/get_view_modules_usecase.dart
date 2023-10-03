import 'package:commerce_app/domain/model/result.dart';

import '../../../../common/utils/common.dart';
import '../../../../common/utils/error/error_response.dart';
import '../../../model/view_module_model.dart';
import '../../../repository/display_repository.dart';
import '../../base/remote_usecase.dart';

class GetViewModulesUseCase extends RemoteUseCase<DisplayRepository> {
  final int tabId;

  GetViewModulesUseCase(this.tabId);

  @override
  Future<Result<List<ViewModuleModel>>> call(
    DisplayRepository repository,
  ) async {
    final result = await repository.getViewModulesByTabId(tabId: tabId);

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
