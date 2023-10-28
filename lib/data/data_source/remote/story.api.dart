import 'package:dio/dio.dart';
import 'package:my_app/data/dto/story/story/story.dto.dart';
import 'package:retrofit/http.dart';

import '../../../core/utils/response_wrappper/response_wrapper.dart';

part 'story.api.g.dart';

@RestApi(baseUrl: "/api/story")
abstract class StoryApi {
  factory StoryApi(Dio dio) = _StoryApi;

  @GET("/list")
  Future<ResponseWrapper<List<StoryDto>>> getStories();
}
