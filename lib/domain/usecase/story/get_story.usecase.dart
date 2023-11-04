import 'package:my_app/core/utils/exception/error_response.dart';
import 'package:my_app/domain/repository/story.repository.dart';
import 'package:my_app/domain/usecase/base/remote.usecase.dart';

import '../../../core/constant/enums/status.enum.dart';
import '../../model/result/result.dart';

class GetStoryUseCase extends RemoteUseCase<StoryRepository> {
  @override
  Future call(StoryRepository repository) async {
    final result = await repository.getStories();
    return result.status == ResponseStatus.success
        ? Result.success(result.data ?? [])
        : Result.failure(ErrorResponse(
            status: 'ERROR', code: result.code, message: result.message));
  }
}
