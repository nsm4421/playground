part of "short.bloc.dart";

@immutable
sealed class ShortState {
}

final class InitialShortState extends ShortState {
}

final class ShortLoadingState extends ShortState {
}

final class ShortSuccessState extends ShortState {
  final List<ShortEntity> shorts;

  ShortSuccessState(this.shorts);
}

final class ShortFailureState extends ShortState {
  final String message;

  ShortFailureState(this.message);
}
