part of '../export.datasource.dart';

class $ReactionDataSourceImpl implements $ReactionDataSource {
  final Dio _dio;
  final Logger _logger;
  final bool _showLog;

  $ReactionDataSourceImpl(
      {required Dio dio, required Logger logger, required bool showLog})
      : _dio = dio,
        _logger = logger,
        _showLog = showLog;

  @override
  Future<int> $count({required int id, required ReactionReference ref}) async {
    if (_showLog) _logger.t('count-like|id:$id/endpoint:${ref.endPoint}');
    return await _dio
        .get(ref.endPoint, queryParameters: {"id": id})
        .then((res) => res.data as int)
        .then((data) {
          if (_showLog) _logger.t(data);
          return data;
        });
  }

  @override
  Future<ReactionDto> $create(
      {required int id, required ReactionReference ref}) async {
    if (_showLog) _logger.t('create-like|id:$id/endpoint:${ref.endPoint}');
    return await _dio
        .post(ref.endPoint, queryParameters: {"id": id})
        .then((res) => res.data as Map<String, dynamic>)
        .then(ReactionDto.fromJson)
        .then((data) {
          if (_showLog) _logger.t(data);
          return data;
        });
  }

  @override
  Future<void> $delete(
      {required int id, required ReactionReference ref}) async {
    if (_showLog) _logger.t('delete-like|id:$id/endpoint:${ref.endPoint}');
    await _dio.delete('${ref.endPoint}/$id').then((data) {
      if (_showLog) _logger.t(data);
      return data;
    });
  }
}
