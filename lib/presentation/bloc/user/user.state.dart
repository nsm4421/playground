part of "user.bloc.dart";

@immutable
sealed class UserState {}

/// 1. 로그인하지 않은 경우
final class NotSignInState extends UserState {}

/// 2. 로그인 한 경우
final class _SignInState extends UserState {
  final User sessionUser;

  _SignInState(this.sessionUser);
}

/// 2-1. 유저정보(닉네임, 프로필)를 등록하지 않은 경우
final class OnBoardingState extends _SignInState {
  OnBoardingState(super.sessionUser);
}

/// 2-1-1. 유저정보(닉네임, 프로필)를 등록하지 않은 경우
final class InitialOnBoardingState extends OnBoardingState {
  InitialOnBoardingState(super.sessionUser);
}

/// 2-1-2. 유저정보(닉네임, 프로필)를 등록하지 않은 경우
final class OnBoardingLoadingState extends OnBoardingState {
  OnBoardingLoadingState(super.sessionUser);
}

/// 2-1-3. 유저정보(닉네임, 프로필)를 등록하지 않은 경우
final class OnBoardingFailureState extends OnBoardingState {
  final String? message;

  OnBoardingFailureState(super.sessionUser, {this.message});
}

/// 2-2. 유저정보(닉네임, 프로필)가 등록된 정상유저인 경우
final class UserLoadedState extends _SignInState {
  final UserEntity currentUser;

  UserLoadedState(super.sessionUser, this.currentUser);
}

/// 2-3. 에러가 발생한 경우
final class UserFailureState extends _SignInState {
  final String? message;

  UserFailureState(super.sessionUser, {this.message});
}
