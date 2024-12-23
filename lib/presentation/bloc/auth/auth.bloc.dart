part of '../export.bloc.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> with LoggerUtil {
  final AuthUseCase _useCase;

  late Stream<UserEntity?> _authStream;
  bool _authenticated = false;

  Stream<UserEntity?> get authStream => _authStream;

  bool get authenticated => _authenticated;

  AuthBloc(this._useCase) : super(AuthState()) {
    on<InitEvent>(_onInit);
    on<GetUserEvent>(_onGetUser);
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
  }

  @override
  Future<void> close() async {
    await _useCase.signOut.call(); // auth bloc이 닫힐 때 자동으로 로그아웃
    await super.close();
  }

  Future<void> _onInit(InitEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: event.status, message: event.message));
  }

  Future<void> _onGetUser(GetUserEvent event, Emitter<AuthState> emit) async {
    try {
      await _useCase.getUser.call().then((res) => res.fold(
          (l) => emit(state.copyWith(status: Status.error, message: l.message)),
          (r) => emit(state
              .copyWith(
                  status: Status.success, message: 'Getting User Succcess')
              .copyWithUser(r.payload))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'Fails'));
    } finally {
      _authenticated = state.user != null;
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.signUp
          .call(
              email: event.email,
              password: event.password,
              username: event.username)
          .then((res) => res.fold(
              (l) => emit(
                  state.copyWith(status: Status.error, message: l.message)),
              (r) => emit(state.copyWith(
                  status: Status.success, message: 'Sign Up Successfully'))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'Sign Up Fails'));
    }
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.signIn
          .call(email: event.email, password: event.password)
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
    } finally {
      _authenticated = state.user != null;
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.signOut.call().then((res) => res.fold(
          (l) => emit(state.copyWith(status: Status.error, message: l.message)),
          (r) => emit(state
              .copyWith(
                  status: Status.success, message: 'Sign Out Successfullly')
              .copyWithUser(null))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'Sign Out Fails'));
    } finally {
      _authenticated = state.user != null;
    }
  }
}
