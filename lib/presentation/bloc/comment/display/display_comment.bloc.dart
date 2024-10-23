import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/display_bloc.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/comment/comment.dart';
import '../../../../domain/entity/meeting/meeting.dart';
import '../../../../domain/usecase/comment/usecase.dart';

class DisplayCommentBloc<T extends BaseEntity>
    extends CustomDisplayBloc<CommentEntity> {
  final T _ref;
  final CommentUseCase _useCase;

  T get ref => _ref;

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
      if (T is MeetingEntity) {
        await _useCase
            .fetchComment(refId: _ref.id!, refTable: Tables.meeting)
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
