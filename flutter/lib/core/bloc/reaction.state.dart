part of '../export.core.dart';

class ReactionState<T> extends SimpleBlocState {
  final T _ref;
  final ReactionEntity? reaction;

  ReactionState(
      {super.status, super.errorMessage, required T ref, this.reaction})
      : _ref = ref;

  bool get like => this.reaction != null;

  @override
  ReactionState<T> copyWith({Status? status, String? errorMessage}) {
    return ReactionState<T>(
        ref: _ref,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  ReactionState<T> copyWithReaction(ReactionEntity? reaction) {
    return ReactionState<T>(
        ref: _ref,
        status: this.status,
        errorMessage: this.errorMessage,
        reaction: reaction);
  }
}
