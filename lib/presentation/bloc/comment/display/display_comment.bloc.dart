import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/display_bloc.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/comment/comment.dart';
import '../../../../domain/entity/meeting/meeting.dart';
import '../../../../domain/usecase/comment/usecase.dart';

class DisplayCommentBloc<Ref extends BaseEntity>
    extends CustomDisplayBloc<CommentEntity> {
  final Ref _ref;
  final CommentUseCase _useCase;

  Ref get ref => _ref;

  DisplayCommentBloc(@factoryParam this._ref, {required CommentUseCase useCase})
      : _useCase = useCase;

  @override
  Future<void> onFetch(FetchEvent<CommentEntity> event,
      Emitter<CustomDisplayState<CommentEntity>> emit) async {
    try {
      emit(state.copyWith(
        status: event.refresh ? Status.loading : state.status,
        isFetching: true,
        data: event.refresh ? [] : state.data,
        isEnd: event.refresh ? false : state.isEnd,
      ));
      // Ref is MeetingEntity라고 조건문 걸면 안 먹음...
      // == 로 하니가 잘 됨
      if (Ref == MeetingEntity) {
        await _useCase
            .fetchComment(_ref)
            .call(beforeAt: state.beforeAt, take: event.take)
            .then((res) => emit(state.from(res, take: event.take)));
      } else {
        throw Exception('given parameter is not valid');
      }
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on fetching data'));
      customUtil.logger.e(error);
    } finally {
      emit(state.copyWith(isFetching: false));
    }
  }
}
