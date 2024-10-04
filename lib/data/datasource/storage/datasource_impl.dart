part of 'datasource.dart';

class StorageDataSourceImpl extends StorageDataSource {
  final SupabaseClient _supabaseClient;

  StorageDataSourceImpl(this._supabaseClient);

  @override
  Future<String> uploadImageAndReturnPublicUrl(
      {required File file,
      required String bucketName,
      String? directory,
      String? filename,
      bool upsert = false}) async {
    final ext = file.path.split('.').last; // 파일 확장자
    final prefix = directory == null ? '' : '$directory/'; // 파일 디렉터리 경로
    final fullFilename = '${filename ?? const Uuid().v4()}.$ext'; // 파일명
    final path = '$prefix$fullFilename';
    final bucket = _supabaseClient.storage.from(bucketName);
    await bucket.uploadBinary(path, await file.readAsBytes(),
        fileOptions: FileOptions(
            contentType: 'image/$ext', cacheControl: '3600', upsert: upsert));
    return bucket.getPublicUrl(path);
  }
}
