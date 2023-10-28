import '../../core/utils/reponse_wrappper/response_wrapper.dart';
import '../model/story/story.model.dart';

abstract class StoryRepository {
  Future<ResponseWrapper<List<StoryModel>>> getStories();
}
