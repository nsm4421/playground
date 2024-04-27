import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
sealed class AddressEvent {
  const AddressEvent();
}

final class InitAddressEvent extends AddressEvent {}
