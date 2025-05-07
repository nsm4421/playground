part of 'bloc.dart';

class AuthenticationState extends BaseState {
  final PresenceEntity? currentUser;

  AuthenticationState({
    super.status,
    super.message,
    this.currentUser,
  });

  @override
  AuthenticationState copyWith({
    Status? status,
    String? message,
    PresenceEntity? currentUser,
  }) {
    return AuthenticationState(
        status: status ?? this.status,
        message: message ?? this.message,
        currentUser: currentUser ?? this.currentUser);
  }

  bool get authenticated => currentUser != null;
}
