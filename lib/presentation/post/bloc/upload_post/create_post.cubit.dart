import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:hot_place/domain/usecase/post/create_post.usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constant/status.costant.dart';
import 'create_post.state.dart';

@injectable
class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit({required CreatePostUseCase createPostUseCase})
      : _createPostUseCase = createPostUseCase,
        super(const CreatePostState());

  final CreatePostUseCase _createPostUseCase;

  static const int _maxImageCount = 3; // 이미지 최대 개수

  final _imagePicker = ImagePicker();
  final _logger = Logger();
  final _tec = TextEditingController(); // 본문 텍스트 컨트롤러

  TextEditingController get tec => _tec;

  void setContent(String text) => emit(state.copyWith(content: text));

  void setHashtags(List<String> hashtags) =>
      emit(state.copyWith(hashtags: hashtags));

  selectImages() async {
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

  deleteImage(int index) {
    List<XFile> assets = [...state.assets];
    assets.removeAt(index);
    emit(state.copyWith(assets: assets));
  }

  upload() async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _createPostUseCase(
        content: state.content,
        hashtags: state.hashtags,
        images: state.images,
      );
      emit(state.copyWith(status: Status.success));
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }
}
