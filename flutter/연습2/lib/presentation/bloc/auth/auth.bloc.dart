part of '../export.bloc.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> with LoggerUtil {
  final AuthUseCase _useCase;

  late Stream<UserEntity?> _authStream;
  late StreamSubscription<UserEntity?> _authSubscription;

  Stream<UserEntity?> get authStream => _authStream;

  AuthBloc(this._useCase) : super(AuthState()) {
    on<InitAuthEvent>(_onInit);
    on<GetUserEvent>(_onGetUser);
    on<SignInEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
    _authStream = _useCase.authStream;
    _authSubscription = _authStream.listen((data) {
      if (data != null) {
        _useCase.initSocket();
      }
    });
  }

  Future<void> _onInit(InitAuthEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: event.status, message: event.message));
  }

  Future<void> _onGetUser(GetUserEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.getUser.call().then((res) => res.fold(
          (l) => emit(state.copyWith(
              status: event.isOnMount ? Status.initial : Status.error,
              message: l.message)),
          (r) => emit(state
              .copyWith(status: Status.success, message: 'Getting User Success')
              .copyWithUser(r.payload))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(
          status: event.isOnMount ? Status.initial : Status.error,
          message: 'Fails'));
    }
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.signIn
          .call(username: event.username, password: event.password)
          .then((res) => res.fold(
              (l) => emit(
                  state.copyWith(status: Status.error, message: l.message)),
              (r) => emit(state
                  .copyWith(
                      status: Status.success, message: 'Sign In Successfully')
                  .copyWithUser(r.payload))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'Sign In Fails'));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.signOut.call().then((res) => res.fold(
          (l) => emit(state.copyWith(status: Status.error, message: l.message)),
          (r) => emit(state
              .copyWith(
                  status: Status.initial, message: 'Sign Out Successfully')
              .copyWithUser(null))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'Sign Out Fails'));
    }
  }
}
