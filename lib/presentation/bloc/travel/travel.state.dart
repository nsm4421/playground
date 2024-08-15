part of "travel.bloc_module.dart";

@sealed
abstract class TravelState {
  Status status;
  String? message;

  TravelState({this.status = Status.initial, this.message});

  TravelState copyWith({Status? status, String? message});
}
