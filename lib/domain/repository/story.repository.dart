import 'package:my_app/domain/repository/repository.dart';

import '../../core/utils/response_wrappper/response_wrapper.dart';
import '../model/story/story.model.dart';

abstract class StoryRepository extends Repository {
  Future<ResponseWrapper<List<StoryModel>>> getStories();
}
