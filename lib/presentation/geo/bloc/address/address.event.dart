@immutable
sealed class AddressState {
  const AddressState();
}

final class InitialAddressState extends AddressState {
  final bool _isPermitted;
final Position _position;
final Address
  
}

final class FeedCommentLoadingState extends AddressState {}

final class FeedCommentFailureState extends AddressState {
  final String message;

  const FeedCommentFailureState(this.message);
}

final class FeedCommentSuccessState extends AddressState {}
