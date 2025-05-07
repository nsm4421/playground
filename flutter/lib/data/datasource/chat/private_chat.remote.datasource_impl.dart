part of '../export.datasource.dart';

class PrivateChatRemoteDataSourceImpl implements PrivateChatRemoteDataSource {
  final Dio _dio;
  final Logger _logger;
  final bool _showLog;

  PrivateChatRemoteDataSourceImpl(
      {required Dio dio, required Logger logger, required bool showLog})
      : _dio = dio,
        _logger = logger,
        _showLog = showLog;

  String get _endPointPrefix => ApiEndPoint.privateChat;

  @override
  Future<Iterable<PrivateChatMessageDto>> fetchLatestMessages() async {
    return await _dio
        .delete(_endPointPrefix)
        .then((res) => res.data as Map<String, dynamic>)
        .then((payload) => payload['data'])
        .then((data) => data.map((PrivateChatMessageDto.fromJson)));
  }

  @override
  Future<Pageable<PrivateChatMessageDto>> fetchMessages({
    int? lastMessageId,
    required String opponentUid,
    required int page,
    int pageSize = 20,
  }) async {
    if (_showLog) {
      _logger.t(
          'fetch|page:$page/pageSize:$pageSize/opponentUid:$opponentUid/lastMessageId:$lastMessageId');
    }
    return await _dio
        .get('$_endPointPrefix/message', queryParameters: {
          if(lastMessageId!=null) "lastMessageId": lastMessageId,
          "opponentUid": opponentUid,
          "page": page,
          "pageSize": pageSize,
        })
        .then((res) => res.data as Map<String, dynamic>)
        .then((json) => Pageable<PrivateChatMessageDto>.fromJson(
            json: json, callback: PrivateChatMessageDto.fromJson))
        .then((data) {
          if (_showLog) _logger.t(data.data.isEmpty? []:data.data.first);
          return data;
        });
  }
}
