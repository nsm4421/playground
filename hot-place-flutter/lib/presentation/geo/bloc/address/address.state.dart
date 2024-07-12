part of 'address.bloc.dart';

@immutable
sealed class AddressState {
  const AddressState();
}

final class InitialAddressState extends AddressState {}

final class LocationFetchedState extends AddressState {
  final Position position;
  final LoadAddressEntity? address;

  const LocationFetchedState({required this.position, required this.address});
}

final class AddressFetchedState extends LocationFetchedState {
  const AddressFetchedState(
      {required Position position, required LoadAddressEntity address})
      : super(position: position, address: address);
}

final class AddressFailureState extends AddressState {
  final String message;

  const AddressFailureState(this.message);
}

final class AddressLoadingState extends AddressState {}
