part of '../export.datasource.dart';

class $CommentDataSourceImpl implements $CommentDataSource {
  final Dio _dio;
  final Logger _logger;
  final bool _showLog;

  $CommentDataSourceImpl(
      {required Dio dio, required Logger logger, required bool showLog})
      : _dio = dio,
        _logger = logger,
        _showLog = showLog;

  @override
  Future<CommentDto> $create(
      {required CommentReference ref,
      required Map<String, dynamic> payload}) async {
    return await _dio
        .post(ref.endPoint, data: payload)
        .then((res) => res.data as Map<String, dynamic>)
        .then(CommentDto.fromJson)
        .then((dto) {
      if (_showLog) _logger.t(dto);
      return dto;
    });
  }

  @override
  Future<CommentDto> $modify(
      {required CommentReference ref,
      required Map<String, dynamic> payload}) async {
    return await _dio
        .put(ref.endPoint, data: payload)
        .then((res) => res.data as Map<String, dynamic>)
        .then(CommentDto.fromJson)
        .then((dto) {
      if (_showLog) _logger.t(dto);
      return dto;
    });
  }

  @override
  Future<void> $delete(
      {required CommentReference ref, required int commentId}) async {
    if (_showLog) {
      _logger.t('delete-comment|endPoint:${ref.endPoint}/id:$commentId');
    }
    final data =
        await _dio.delete('${ref.endPoint}/$commentId').then((res) => res.data);
    if (_showLog) _logger.t(data);
  }

  @override
  Future<Pageable<CommentDto>> $fetch(
      {required int page,
      int pageSize = 20,
      required CommentReference ref,
      required int refId}) async {
    if (_showLog) {
      _logger.t(
          'fetch-comment|page:$page/pageSize:$pageSize/endPoint:${ref.endPoint}/id:$refId');
    }
    return await _dio
        .get('${ref.endPoint}/$refId', queryParameters: {
          "page": page,
          "pageSize": pageSize,
        })
        .then((res) => res.data as Map<String, dynamic>)
        .then((json) {
          final data = Pageable<CommentDto>.fromJson(
              json: json, callback: CommentDto.fromJson);
          if (_showLog) _logger.t(data);
          return data;
        });
  }
}
