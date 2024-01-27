import 'package:my_app/domain/model/feed/feed.model.dart';

import '../../core/constant/feed.enum.dart';
import '../../core/response/response.dart';
import '../../repository/feed/feed.repository.dart';
import '../base/remote.usecase.dart';

class SearchFeedUsecase extends RemoteUsecase<FeedRepository> {
  SearchFeedUsecase({required this.option, required this.keyword});

  final SearchOption option;
  final String keyword;

  @override
  Future call(FeedRepository repository) async {
    if (keyword.isEmpty) {
      return const Response<List<FeedModel>>(
          status: Status.warning, message: 'keyword is empty');
    }
    return await repository.searchFeed(option: option, keyword: keyword);
  }
}
