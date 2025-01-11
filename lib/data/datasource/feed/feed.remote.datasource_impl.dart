part of '../export.datasource.dart';

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final Dio _dio;
  final Logger _logger;

  FeedRemoteDataSourceImpl({required Dio dio, required Logger logger})
      : _dio = dio,
        _logger = logger;

  @override
  Future<Pageable<FeedDto>> fetch(
      {required int page, int pageSize = 20}) async {
    return await _dio
        .get(ApiEndPoint.fetchFeed, queryParameters: {
          "page": page,
          "pageSize": pageSize,
        })
        .then((res) => res.data as Map<String, dynamic>)
        .then((json) =>
            Pageable<FeedDto>.fromJson(json: json, callback: FeedDto.fromJson));
  }

  @override
  Future<void> create(
      {required List<File> files, required CreateFeedDto dto}) async {
    final multiPartFile = await Future.wait(
        files.map((f) async => await MultipartFile.fromFile(f.path)));
    await _dio
        .post(ApiEndPoint.createFeed,
            data: dto.toFormData(multiPartFile: multiPartFile))
        .then((res) => res.data)
        .then(_logger.d);
  }

  @override
  Future<void> modify(
      {required List<File> files, required ModifyFeedDto dto}) async {
    final multiPartFile = await Future.wait(
        files.map((f) async => await MultipartFile.fromFile(f.path)));
    await _dio
        .put(ApiEndPoint.modifyFeed,
            data: dto.toFormData(multiPartFile: multiPartFile))
        .then((res) => res.data)
        .then(_logger.d);
  }

  @override
  Future<void> delete(int id) async {
    await _dio
        .delete(ApiEndPoint.deleteFeed)
        .then((res) => res.data)
        .then(_logger.d);
  }
}
