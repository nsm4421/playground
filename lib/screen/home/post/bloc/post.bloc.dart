import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/screen/home/post/bloc/post.event.dart';
import 'package:my_app/screen/home/post/bloc/post.state.dart';
import 'package:my_app/usecase/feed/submit_post.usecase.dart';

import '../../../../core/response/response.dart';
import '../../../../usecase/feed/feed.usecase.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final FeedUsecase _feedUsecase;

  PostBloc(this._feedUsecase) : super(const PostState()) {
    on<InitPostEvent>(_onInit);
    on<UpdatePostStateEvent>(_onUpdate);
    on<SubmitPostEvent>(_onSubmit);
  }

  void _onInit(InitPostEvent event, Emitter<PostState> emit) {
    try {
      emit(state.copyWith(status: PostStatus.initial));
    } catch (err) {
      emit(const PostState(status: PostStatus.error));
    }
  }

  void _onUpdate(UpdatePostStateEvent event, Emitter<PostState> emit) {
    try {
      emit(event.state.copyWith(status: PostStatus.initial));
    } catch (err) {
      emit(const PostState(status: PostStatus.error));
    }
  }

  void _onSubmit(SubmitPostEvent event, Emitter<PostState> emit) async {
    try {
      emit(state.copyWith(status: PostStatus.loading));
      final Response<String> response = await _feedUsecase.execute(
          useCase: SubmitPostUsecase(
              content: event.content,
              hashtags: event.hashtags,
              images: event.images));
      switch (response.status) {
        case Status.success:
          emit(state.copyWith(status: PostStatus.success));
        case Status.warning:
          emit(state.copyWith(status: PostStatus.initial));
        case Status.error:
          emit(state.copyWith(status: PostStatus.error));
      }
    } catch (err) {
      emit(const PostState(status: PostStatus.error));
    }
  }
}
