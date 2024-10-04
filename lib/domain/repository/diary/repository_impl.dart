part of 'repository.dart';

@LazySingleton(as: DiaryRepository)
class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryDataSource _diaryDataSource;
  final StorageDataSource _storageDataSource;

  DiaryRepositoryImpl({
    required DiaryDataSource diaryDataSource,
    required StorageDataSource storageDataSource,
  })  : _diaryDataSource = diaryDataSource,
        _storageDataSource = storageDataSource;

  @override
  Future<Either<ErrorResponse, void>> edit(
      {required String id,
      String? location,
      required List<String> hashtags,
      required List<File?> images,
      required List<String> captions,
      required bool isPrivate,
      bool update = false}) async {
    try {
      return await _diaryDataSource
          .edit(EditDiaryModel(
              id: id,
              location: location,
              hashtags: hashtags,
              images:
                  await _saveImagesAndReturnPublicUrls(id: id, images: images),
              captions: captions,
              is_private: isPrivate))
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> delete(String id) async {
    try {
      return await _diaryDataSource.deleteById(id).then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  Future<List<String>> _saveImagesAndReturnPublicUrls(
      {required String id, required List<File?> images}) async {
    return images.isEmpty
        ? []
        : await Future.wait(List.generate(images.length, (index) async {
            final image = images[index];
            return image == null
                ? ''
                : await _storageDataSource.uploadImageAndReturnPublicUrl(
                    file: image,
                    filename: '${id}_$index.jpg',
                    bucketName: 'diaries');
          }));
  }
}
