part of 'user.bloc.dart';

@immutable
sealed class UserState {
  const UserState();
}

final class NotAuthenticatedState extends UserState {}

final class OnBoardingState extends UserState {
  final User sessionUser;

  const OnBoardingState(this.sessionUser);
}

final class UserLoadedState extends UserState {
  final User sessionUser;
  final AccountEntity account;

  const UserLoadedState({required this.sessionUser, required this.account});
}

final class UserLoadingState extends UserState {}

final class UserFailureState extends UserState {}
