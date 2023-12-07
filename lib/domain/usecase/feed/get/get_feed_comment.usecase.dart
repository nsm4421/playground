import 'package:my_app/core/constant/enums/status.enum.dart';
import 'package:my_app/domain/model/feed/feed_comment.model.dart';
import 'package:my_app/domain/repository/feed.repository.dart';
import 'package:my_app/domain/usecase/base/remote.usecase.dart';

import '../../../../core/utils/exception/error_response.dart';
import '../../../model/result/result.dart';

class GetFeedCommentUseCase extends RemoteUseCase<FeedRepository> {
  GetFeedCommentUseCase(this.feedId);

  final String feedId;

  @override
  Future call(FeedRepository repository) async {
    final result = await repository.getFeedComments(feedId);
    return result.status == ResponseStatus.success
        ? Result<List<FeedCommentModel>>.success(
            result.data ?? <FeedCommentModel>[])
        : Result<List<FeedCommentModel>>.failure(ErrorResponse(
            status: 'ERROR', code: result.code, message: result.message));
  }
}
