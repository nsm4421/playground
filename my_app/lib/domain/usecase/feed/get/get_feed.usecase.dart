import 'package:my_app/domain/repository/feed.repository.dart';

import '../../../../core/constant/enums/status.enum.dart';
import '../../../../core/utils/exception/error_response.dart';
import '../../../model/feed/feed.model.dart';
import '../../../model/result/result.dart';
import '../../base/remote.usecase.dart';

class GetFeedUseCase extends RemoteUseCase<FeedRepository> {
  GetFeedUseCase();

  @override
  Future call(FeedRepository repository) async {
    final result = await repository.getFeeds();
    return result.status == ResponseStatus.success
        ? Result<List<FeedModel>>.success(result.data ?? [])
        : Result<List<FeedModel>>.failure(ErrorResponse(
            status: 'ERROR', code: result.code, message: result.message));
  }
}
