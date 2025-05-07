part of '../export.datasource.dart';

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final Dio _dio;
  final Logger _logger;
  final bool _showLog;

  FeedRemoteDataSourceImpl(
      {required Dio dio, required Logger logger, required bool showLog})
      : _dio = dio,
        _logger = logger,
        _showLog = showLog;

  String get _endPointPrefix => ApiEndPoint.feed;

  @override
  Future<Pageable<FeedDto>> fetch(
      {required int page, int pageSize = 20}) async {
    if (_showLog) _logger.t('fetch|page:$pageSize/pageSize:$pageSize');
    return await _dio
        .get(_endPointPrefix, queryParameters: {
          "page": page,
          "pageSize": pageSize,
        })
        .then((res) => res.data as Map<String, dynamic>)
        .then((json) =>
            Pageable<FeedDto>.fromJson(json: json, callback: FeedDto.fromJson))
        .then((data) {
          if (_showLog) _logger.t(data);
          return data;
        });
  }

  @override
  Future<void> create(
      {required List<File> files, required CreateFeedDto dto}) async {
    if (_showLog) _logger.t('create|content:${dto.content}');
    final multiPartFile = await Future.wait(
        files.map((f) async => await MultipartFile.fromFile(f.path)));
    return await _dio
        .post(_endPointPrefix,
            data: dto.toFormData(multiPartFile: multiPartFile))
        .then((res) => res.data)
        .then((data) {
      if (_showLog) _logger.t(data);
      return data;
    });
  }

  @override
  Future<void> modify(
      {required List<File> files, required ModifyFeedDto dto}) async {
    if (_showLog) _logger.t('modify|id:${dto.id}/content:${dto.content}');
    final multiPartFile = await Future.wait(
        files.map((f) async => await MultipartFile.fromFile(f.path)));
    return await _dio
        .put(_endPointPrefix,
            data: dto.toFormData(multiPartFile: multiPartFile))
        .then((res) => res.data)
        .then((data) {
      if (_showLog) _logger.t(data);
      return data;
    });
  }

  @override
  Future<void> delete(int id) async {
    if (_showLog) _logger.t('delete|id:$id');
    return await _dio
        .delete('$_endPointPrefix/$id')
        .then((res) => res.data)
        .then((data) {
      if (_showLog) _logger.t(data);
      return data;
    });
  }
}
