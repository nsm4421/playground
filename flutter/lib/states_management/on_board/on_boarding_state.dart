import 'package:chat/chat.dart';
import 'package:equatable/equatable.dart';

abstract class OnBoardingState extends Equatable {}

class OnBoardingInitial extends OnBoardingState {
  @override
  List<Object> get props => [];
}

class OnBoardingLoading extends OnBoardingState {
  @override
  List<Object> get props => [];
}

class OnBoardingSuccess extends OnBoardingState {
  final User _user;

  OnBoardingSuccess(this._user);

  @override
  List<Object> get props => [_user];
}
