part of '../export.core.dart';

abstract class ReactionCubit<T> extends Cubit<ReactionState<T>> {
  ReactionCubit(super.initialState);

  void initialize({Status? status, String? errorMessage});

  Future<void> like();

  Future<void> cancelLike();
}
