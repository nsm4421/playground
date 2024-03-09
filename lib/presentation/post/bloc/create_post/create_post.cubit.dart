import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/domain/usecase/post/upload_post_images.usecase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:hot_place/domain/usecase/post/create_post.usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constant/status.costant.dart';
import 'create_post.state.dart';

@injectable
class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit(
      {required CreatePostUseCase createPostUseCase,
      required UploadPostImagesUseCase uploadPostImagesUseCase})
      : _createPostUseCase = createPostUseCase,
        _uploadPostImagesUseCase = uploadPostImagesUseCase,
        super(const CreatePostState());

  final CreatePostUseCase _createPostUseCase;
  final UploadPostImagesUseCase _uploadPostImagesUseCase;

  static const int _maxImageCount = 3; // 이미지 최대 개수

  final _imagePicker = ImagePicker();
  final _logger = Logger();
  final _tec = TextEditingController(); // 본문 텍스트 컨트롤러

  TextEditingController get tec => _tec;

  void setHashtags(List<String> hashtags) =>
      emit(state.copyWith(hashtags: hashtags));

  Future<void> selectImages() async {
    try {
      List<XFile> temp = await _imagePicker.pickMultiImage();
      if (temp.length > _maxImageCount) {
        temp = temp.sublist(0, _maxImageCount);
      }
      emit(state.copyWith(assets: temp));
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }

  void deleteImage(int index) {
    List<XFile> assets = [...state.assets];
    assets.removeAt(index);
    emit(state.copyWith(assets: assets));
  }

  Future<void> uploadPost() async {
    try {
      // 로딩중으로 상태 변경
      emit(state.copyWith(status: Status.loading));

      // 이미지 업로드
      if (state.assets.isNotEmpty) {
        emit(state.copyWith(
            images: await _uploadPostImagesUseCase(state.assets)));
      }

      // 포스팅 업로드
      await _createPostUseCase(
        content: _tec.text.trim(),
        hashtags: state.hashtags,
        images: state.images,
      );

      // 성공
      emit(state.copyWith(status: Status.success));
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }
}
