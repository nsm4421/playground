import 'package:flutter_bloc/flutter_bloc.dart';
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

  void setContent(String text) => emit(state.copyWith(content: text));

  void setHashtags(List<String> hashtags) =>
      emit(state.copyWith(hashtags: hashtags));

  void upload() async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _createPostUseCase(
        content: state.content,
        hashtags: state.hashtags,
        images: state.images,
      );
      emit(state.copyWith(status: Status.success));
    } catch (err) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
