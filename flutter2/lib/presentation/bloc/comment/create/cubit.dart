import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/domain/usecase/comment/usecase.dart';
import 'package:uuid/uuid.dart';

part 'state.dart';

class CreateCommentCubit<RefEntity extends BaseEntity>
    extends Cubit<CreateCommentState<RefEntity>> with CustomLogger {
  late String _commentId; // 저장할 댓글의 id
  final CommentUseCase useCase;
  final RefEntity _ref;

  CreateCommentCubit(@factoryParam this._ref, {required this.useCase})
      : super(CreateCommentState<RefEntity>(_ref)) {
    _commentId = const Uuid().v4();
  }

  String get commentId => _commentId;

  void initState({Status? status, String? message}) {
    emit(state.copyWith(
      status: status ?? state.status,
      message: message ?? state.message,
    ));
  }

  void handleContent(String content) {
    emit(state.copyWith(content: content));
  }

  Future<void> handleSubmitParentComment() async {
    try {
      if (state.content.isEmpty) {
        emit(state.copyWith(
            status: Status.error, message: 'comment is not given'));
        return;
      }
      emit(state.copyWith(status: Status.loading));
      await useCase.create
          .call(
            id: _commentId,
            referenceId: _ref.id!,
            referenceTable: _ref.table.name,
            content: state.content,
          )
          .then((res) => res.fold(
                  (l) => emit(
                      state.copyWith(status: Status.error, message: l.message)),
                  (r) {
                emit(state.copyWith(
                    status: Status.success, message: '', content: ''));
                _commentId = const Uuid().v4();
              }));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error, message: 'cancel create comment fails'));
      logger.e(error);
    }
  }

  Future<void> handleSubmitChildComment(String parentId) async {
    try {
      if (state.content.isEmpty) {
        emit(state.copyWith(
            status: Status.error, message: 'comment is not given'));
        return;
      }
      emit(state.copyWith(status: Status.loading));
      await useCase.create
          .call(
            id: _commentId,
            parentId: parentId,
            referenceId: _ref.id!,
            referenceTable: _ref.table.name,
            content: state.content,
          )
          .then((res) => res.fold(
                  (l) => emit(
                      state.copyWith(status: Status.error, message: l.message)),
                  (r) {
                emit(state.copyWith(
                    status: Status.success, message: '', content: ''));
                _commentId = const Uuid().v4();
              }));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error, message: 'cancel create comment fails'));
      logger.e(error);
    }
  }
}
