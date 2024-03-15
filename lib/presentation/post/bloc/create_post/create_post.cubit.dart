import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/domain/usecase/post/upload_post_images.usecase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:hot_place/domain/usecase/post/create_post.usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constant/response.constant.dart';
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

  final _logger = Logger();

  void setContent(String content) => emit(state.copyWith(content: content));

  void setHashtags(List<String> hashtags) =>
      emit(state.copyWith(hashtags: hashtags));

  void setAssets(List<XFile> assets) => emit(state.copyWith(assets: assets));

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
      (await _uploadPostImagesUseCase(state.assets)).when(success: (data) {
        emit(state.copyWith(images: data));
      }, failure: (code, description) {
        throw Exception("error-code:$code: ($description)");
      });

      // 포스팅 업로드
      (await _createPostUseCase(
        content: state.content,
        hashtags: state.hashtags,
        images: state.images,
      ))
          .when(success: (data) {
        emit(state.copyWith(status: Status.success));
      }, failure: (code, description) {
        throw Exception("error-code:$code: ($description)");
      });
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }
}
