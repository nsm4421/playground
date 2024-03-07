import 'dart:io';

import 'package:hot_place/domain/repository/post/post.repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@singleton
class UploadPostImagesUseCase {
  final PostRepository _postRepository;

  UploadPostImagesUseCase(this._postRepository);

  Future<List<String>> call(List<XFile> assets) async =>
      _postRepository.uploadImages(assets.map((e) => File(e.path)).toList());
}
