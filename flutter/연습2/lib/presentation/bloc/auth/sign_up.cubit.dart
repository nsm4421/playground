part of '../export.bloc.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> with LoggerUtil, ImageUtil {
  late GlobalKey<FormState> _formKey;
  final AuthUseCase _useCase;

  SignUpCubit(this._useCase) : super(SignUpState()) {
    _formKey = GlobalKey<FormState>(debugLabel: 'sign up cubit form key');
  }

  GlobalKey<FormState> get formKey => _formKey;

  void update(
      {Status? status,
      String? errorMessage,
      String? email,
      String? username,
      String? nickname,
      String? password}) {
    emit(
      state.copyWith(
        status: status ?? state.status,
        errorMessage: errorMessage ?? state.errorMessage,
        email: email ?? state.email,
        username: username ?? state.username,
        nickname: nickname ?? state.nickname,
        password: password ?? state.password,
      ),
    );
  }

  void selectImage() {
    onSelectSingleImage((file) async {
      emit(state.copyWithProfileImage(file));
    });
  }

  void unSelectImage() {
    emit(state.copyWithProfileImage(null));
  }

  Future<void> submit() async {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    } else if (state.profileImage == null || state.status != Status.initial) {
      return;
    }

    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .signUp(
              email: state.email,
              password: state.password,
              username: state.username,
              nickname: state.nickname,
              profileImage: File(state.profileImage!.path))
          .then((res) => res.fold(
              (l) => emit(state.copyWith(
                  status: Status.error, errorMessage: l.message)),
              (r) => emit(
                  state.copyWith(status: Status.success, errorMessage: ''))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, errorMessage: 'error occurs'));
    }
  }
}
