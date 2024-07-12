part of 'address.bloc.dart';

@immutable
sealed class AddressEvent {
  const AddressEvent();
}

final class InitAddressEvent extends AddressEvent {}
