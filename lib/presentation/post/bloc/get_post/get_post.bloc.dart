import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/domain/usecase/post/get_post_stream.usecase.dart';
import 'package:hot_place/domain/usecase/post/like/cancel_like_post.usecase.dart';
import 'package:hot_place/domain/usecase/post/like/like_post.usecase.dart';
import 'package:hot_place/presentation/post/bloc/get_post/get_post.event.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/constant/response.constant.dart';

import 'get_post.state.dart';

@injectable
class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  GetPostBloc({
    required GetPostStreamUseCase getPostStreamUseCase,
    required LikePostUseCase likePostUseCase,
    required CancelLikePostUseCase cancelLikePostUseCase,
  })  : _getPostStreamUseCase = getPostStreamUseCase,
        _likePostUseCase = likePostUseCase,
        _cancelLikePostUseCase = cancelLikePostUseCase,
        super(const GetPostState()) {
    on<InitPost>(_onInit);
    on<LikePost>(_onLikePost);
    on<CancelLikePost>(_onCancelLikePost);
  }

  final _logger = Logger();
  final GetPostStreamUseCase _getPostStreamUseCase;
  final LikePostUseCase _likePostUseCase;
  final CancelLikePostUseCase _cancelLikePostUseCase;

  void _onInit(
    InitPost event,
    Emitter<GetPostState> emit,
  ) {
    try {
      (_getPostStreamUseCase()).when(success: (data) {
        emit(state.copyWith(stream: data, status: Status.success));
      }, failure: (code, description) {
        throw Exception("error-code:$code: ($description)");
      });
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onLikePost(
    LikePost event,
    Emitter<GetPostState> emit,
  ) async {
    try {
      (await _likePostUseCase(event.postId)).when(success: (data) {
        emit(state.copyWith(status: Status.success));
      }, failure: (code, description) {
        throw Exception("error-code:$code: ($description)");
      });
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onCancelLikePost(
    CancelLikePost event,
    Emitter<GetPostState> emit,
  ) async {
    try {
      (await _cancelLikePostUseCase(poseId: event.postId, likeId: event.likeId))
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
