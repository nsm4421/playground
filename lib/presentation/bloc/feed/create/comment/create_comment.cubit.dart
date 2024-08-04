import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/presentation/bloc/feed/create/comment/create_comment.state.dart';

import '../../../../../core/constant/status.dart';
import '../../../../../domain/usecase/feed/feed.usecase_module.dart';

class CreateCommentCubit extends Cubit<CreateCommentState> {
  final String _feedId;
  final FeedUseCase _useCase;

  CreateCommentCubit(@factoryParam this._feedId, {required FeedUseCase useCase})
      : _useCase = useCase,
        super(const CreateCommentState());

  init() {
    emit(state.copyWith(status: Status.initial));
  }


  Future<void> submit(String content) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res =
          await _useCase.createComment(feedId: _feedId, content: content);
      if (res.ok) {
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(
            status: Status.error,
            message: res.message ?? 'fail to create comment'));
      }
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, message: 'fail to create comment'));
    }
  }
}
