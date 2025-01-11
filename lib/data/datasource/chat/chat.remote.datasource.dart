part of '../export.datasource.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio _dio;
  final Logger _logger;

  ChatRemoteDataSourceImpl({required Dio dio, required Logger logger})
      : _dio = dio,
        _logger = logger;

  @override
  Future<void> create(
      {required String title, required List<String> hashtags}) async {
    await _dio.post(ApiEndPoint.createChat, data: {
      "title": title,
      "hashtags": hashtags,
    }).then((res) {
      _logger.d(res.data);
    });
  }

  @override
  Future<Pageable<GroupChatDto>> fetch(
      {required int page, int pageSize = 20}) async {
    return await _dio
        .get(ApiEndPoint.fetchChat, queryParameters: {
          "page": page,
          "pageSize": pageSize,
        })
        .then((res) => res.data as Map<String, dynamic>)
        .then((json) => Pageable<GroupChatDto>.fromJson(
            json: json, callback: GroupChatDto.fromJson));
  }
}
