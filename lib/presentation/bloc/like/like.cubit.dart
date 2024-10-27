import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/domain/usecase/like/usecase.dart';

import '../../../core/constant/constant.dart';

part 'like.state.dart';

class LikeCubit<Ref extends BaseEntity> extends Cubit<LikeState> {
  LikeCubit(@factoryParam this._ref, {required LikeUseCase useCase})
      : _useCase = useCase,
        super(LikeState());

  final Ref _ref;
  final LikeUseCase _useCase;

  init({Status? status, bool? isLike, int? likeCount, String? errorMessage}) {
    emit(state.copyWith(
        status: status,
        isLike: isLike,
        likeCount: likeCount,
        errorMessage: errorMessage));
  }

  sendLike() async {
    try {
      customUtil.logger.t('like request');
      emit(state.copyWith(status: Status.loading));
      await _useCase.like(_ref).call().then((res) => res.fold(
          (l) => emit(
              state.copyWith(status: Status.error, errorMessage: l.message)),
          (r) => emit(state.copyWith(
              status: Status.success,
              isLike: true,
              likeCount: state.likeCount + 1,
              errorMessage: ''))));
    } catch (error) {
      customUtil.logger.e(error);
      emit(state.copyWith(
          status: Status.error, errorMessage: 'like request fails'));
    }
  }

  cancelLike() async {
    try {
      customUtil.logger.t('cancel like request');
      emit(state.copyWith(status: Status.loading));
      await _useCase.cancel(_ref).call().then((res) => res.fold(
          (l) => emit(
              state.copyWith(status: Status.error, errorMessage: l.message)),
          (r) => emit(state.copyWith(
              status: Status.success,
              isLike: false,
              likeCount: state.likeCount - 1,
              errorMessage: ''))));
    } catch (error) {
      customUtil.logger.e(error);
      emit(state.copyWith(
          status: Status.error, errorMessage: 'cancel like request fails'));
    }
  }
}
