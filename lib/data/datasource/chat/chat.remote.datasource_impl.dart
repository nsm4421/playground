part of '../export.datasource.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio _dio;
  final Logger _logger;
  final bool _showLog;

  ChatRemoteDataSourceImpl(
      {required Dio dio, required Logger logger, required bool showLog})
      : _dio = dio,
        _logger = logger,
        _showLog = showLog;

  String get _endPointPrefix => ApiEndPoint.chat;

  @override
  Future<void> create(
      {required String title, required List<String> hashtags}) async {
    if (_showLog) {
      _logger.t('create|title:$title/hashtags:#${hashtags.join(",")}');
    }
    return await _dio
        .post(_endPointPrefix, data: {
          "title": title,
          "hashtags": hashtags,
        })
        .then((res) => res.data)
        .then((data) {
          if (_showLog) _logger.t(data);
        });
  }

  @override
  Future<Pageable<GroupChatDto>> fetch(
      {required int page, int pageSize = 20}) async {
    if (_showLog) {
      _logger.t('fetch|page:$page/pageSize:$pageSize');
    }
    return await _dio
        .get(_endPointPrefix, queryParameters: {
          "page": page,
          "pageSize": pageSize,
        })
        .then((res) => res.data as Map<String, dynamic>)
        .then((json) => Pageable<GroupChatDto>.fromJson(
            json: json, callback: GroupChatDto.fromJson))
        .then((data) {
          if (_showLog) _logger.t(data);
          return data;
        });
  }

  @override
  Future<void> delete(String chatId) async {
    if (_showLog) {
      _logger.t('delete|chatId:$chatId');
    }
    await _dio
        .delete('$_endPointPrefix/$chatId')
        .then((res) => res.data)
        .then((data) {
      if (_showLog) _logger.t(data);
    });
  }
}
