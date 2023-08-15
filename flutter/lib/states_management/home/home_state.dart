import 'package:chat/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeSuccess extends HomeState {
  final List<User> activeUsers;

  HomeSuccess(this.activeUsers);

  @override
  List<Object> get props => [activeUsers];
}
