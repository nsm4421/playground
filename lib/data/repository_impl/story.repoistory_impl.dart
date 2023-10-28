import 'package:my_app/core/utils/reponse_wrappper/response_wrapper.dart';
import 'package:my_app/core/utils/reponse_wrappper/response_wrapper_extension.dart';
import 'package:my_app/data/mapper/story_mapper.dart';
import 'package:my_app/domain/model/story/story.model.dart';
import 'package:my_app/domain/repository/story.repository.dart';

import '../data_source/remote/story.api.dart';

class StoryRepositoryImpl extends StoryRepository {
  final StoryApi _storyApi;

  StoryRepositoryImpl(this._storyApi);

  @override
  Future<ResponseWrapper<List<StoryModel>>> getStories() async {
    final response = await _storyApi.getStories();
    final stories = response.data?.map((e) => e.toModel()).toList() ?? [];
    return response.toModel<List<StoryModel>>(stories);
  }
}
