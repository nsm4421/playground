import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/bloc/display_bloc.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/domain/entity/comment/comment.dart';
import 'package:travel/domain/usecase/comment/usecase.dart';

class DisplayCommentBloc<RefEntity extends BaseEntity>
    extends CustomDisplayBloc<CommentEntity> with CustomLogger {
  final CommentUseCase _useCase;
  final RefEntity _ref;

  DisplayCommentBloc(@factoryParam this._ref, {required CommentUseCase useCase})
      : _useCase = useCase;

  @override
  Future<void> onFetch(FetchEvent<CommentEntity> event,
      Emitter<CustomDisplayState<CommentEntity>> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.fetch
          .call(
              referenceId: _ref.id!,
              referenceTable: _ref.table.name,
              beforeAt: event.refresh ? currentDt : state.beforeAt,
              take: event.take)
          .then((res) => res.fold(
              (l) => emit(state.copyWith(
                  status: Status.error, errorMessage: l.message)),
              (r) => emit(state.copyWith(
                  status: Status.success,
                  errorMessage: '',
                  data: event.refresh ? r : [...state.data, ...r],
                  isEnd: r.length < event.take))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(
          status: Status.error, errorMessage: 'fail to fetch feed'));
    }
  }
}
