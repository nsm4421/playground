import '../../core/response/response.dart';
import '../../repository/feed/feed.repository.dart';
import '../base/remote.usecase.dart';

class SaveFeedCommentUsecase extends RemoteUsecase<FeedRepository> {
  SaveFeedCommentUsecase(
      {required this.fid, required this.content, required this.parentCid});

  final String fid;
  final String content;
  final String? parentCid;

  @override
  Future call(FeedRepository repository) async {
    if (content.isEmpty) {
      return const Response<String>(
          status: Status.warning, message: 'Content is empty');
    }
    if (fid.isEmpty) {
      return const Response<String>(
          status: Status.warning, message: 'fid is missing');
    }
    return await repository.saveFeedComment(
        fid: fid, parentCid: parentCid, content: content);
  }
}
