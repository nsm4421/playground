import 'package:commerce_app/domain/model/result.dart';

import '../../../../common/utils/common.dart';
import '../../../../common/utils/error/error_response.dart';
import '../../../model/view_module_model.dart';
import '../../../repository/display_repository.dart';
import '../../base/remote_usecase.dart';

class GetViewModulesUseCase extends RemoteUseCase<DisplayRepository> {
  final int tabId;
  final int page;

  GetViewModulesUseCase({required this.tabId, this.page = 1});

  @override
  Future<Result<List<ViewModuleModel>>> call(
    DisplayRepository repository,
  ) async {
    final result = await repository.getViewModulesByTabIdAndPage(tabId: tabId, page: page);

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
