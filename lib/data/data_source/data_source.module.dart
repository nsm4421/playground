import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/data_source/mock/mock_story.api.dart';
import 'package:my_app/data/data_source/remote/story.api.dart';

import '../../core/constant/rest_client.dart';

@module
abstract class DataSourceModule {
  final Dio _dio = RestClient().dio;

  // TODO : Mock API 대신 Story API로 수정하기
  // StoryApi get storyApi => StoryApi(_dio);
  @singleton
  StoryApi get storyApi => MockStoryApi();
}
