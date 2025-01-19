part of '../export.datasource.dart';

class ReactionRemoteDataSourceImpl implements ReactionRemoteDataSource {
  final Dio _dio;
  final Logger _logger;

  ReactionRemoteDataSourceImpl({required Dio dio, required Logger logger})
      : _dio = dio,
        _logger = logger;

  @override
  Future<int> count({required int id, required ReactionReference ref}) async {
    return await _dio.get(ref.endPoint,
        queryParameters: {"id": id}).then((res) => res.data as int);
  }

  @override
  Future<ReactionDto> create(
      {required int id, required ReactionReference ref}) async {
    _logger.d('id:$id|ref:${ref.endPoint}');
    return await _dio
        .post(ref.endPoint, queryParameters: {"id": id})
        .then((res) => res.data as Map<String, dynamic>)
        .then(ReactionDto.fromJson);
  }

  @override
  Future<void> delete({required int id, required ReactionReference ref}) async {
    _logger.d('id:$id|ref:${ref.endPoint}');
    await _dio.delete('${ref.endPoint}/$id');
  }
}
