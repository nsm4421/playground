import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/meeting/meeting.dart';
import '../../../../domain/usecase/comment/usecase.dart';

part 'edit_comment.state.dart';

part 'edit_comment.event.dart';

class EditCommentBloc<Ref extends BaseEntity>
    extends Bloc<CommentEvent, EditCommentState> {
  final CommentUseCase _useCase;
  final Ref _ref;

  Ref get ref => _ref;

  EditCommentBloc(@factoryParam this._ref, {required CommentUseCase useCase})
      : _useCase = useCase,
        super(EditCommentState()) {
    on<InitCommentEvent>(_onInit);
    on<CreateCommentEvent>(_onCreate);
    on<ModifyCommentEvent>(_onModify);
    on<DeleteCommentEvent>(_onDelete);
  }

  Future<void> _onInit(
      InitCommentEvent event, Emitter<EditCommentState> emit) async {
    emit(state.copyWith(
        status: event.status,
        content: event.content,
        errorMessage: event.errorMessage));
  }

  Future<void> _onCreate(
      CreateCommentEvent event, Emitter<EditCommentState> emit) async {
    try {
      await _useCase
          .createComment(_ref)
          .call(refId: _ref.id!, content: event.content)
          .then((res) => res.fold(
              (l) => emit(state.copyWith(
                  status: Status.error, errorMessage: l.message)),
              (r) => emit(
                  state.copyWith(status: Status.success, errorMessage: ''))));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on fetching data'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onModify(
      ModifyCommentEvent event, Emitter<EditCommentState> emit) async {
    try {
      await _useCase
          .modify(commentId: event.commentId, content: event.content)
          .then((res) => res.fold(
              (l) => emit(state.copyWith(
                  status: Status.error, errorMessage: l.message)),
              (r) => state.copyWith(status: Status.success, errorMessage: '')));
      ;
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on modify data'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onDelete(
      DeleteCommentEvent event, Emitter<EditCommentState> emit) async {
    try {
      await _useCase.delete(event.commentId).then((res) => res.fold(
          (l) => emit(
              state.copyWith(status: Status.error, errorMessage: l.message)),
          (r) => state.copyWith(status: Status.success, errorMessage: '')));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on delete data'));
      customUtil.logger.e(error);
    }
  }
}
