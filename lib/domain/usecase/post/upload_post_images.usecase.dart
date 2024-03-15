import 'dart:io';

import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/repository/post/post.repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@singleton
class UploadPostImagesUseCase {
  final PostRepository _postRepository;

  UploadPostImagesUseCase(this._postRepository);

  Future<ResultEntity<List<String>>> call(List<XFile> assets) async =>
      await _postRepository
          .uploadImages(assets.map((e) => File(e.path)).toList())
          .then((res) => ResultEntity.fromResponse(res));
}
