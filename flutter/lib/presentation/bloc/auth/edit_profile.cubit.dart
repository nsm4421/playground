part of '../export.bloc.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState>
    with LoggerUtil, ImageUtil {
  final AuthUseCase _useCase;
  final UserEntity _currentUser;

  EditProfileCubit(
    @factoryParam this._currentUser, {
    required AuthUseCase useCase,
  })  : _useCase = useCase,
        super(EditProfileState(nickname: _currentUser.nickname));

  UserEntity get currentUser => _currentUser;

  void update({Status? status, String? errorMessage, String? nickname}) {
    emit(
      state.copyWith(
        status: status ?? state.status,
        errorMessage: errorMessage ?? state.errorMessage,
        nickname: nickname ?? state.nickname,
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
    try {
      if (state.nickname == currentUser.nickname && state.profileImage == null)
        return;
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .editProfile(
            nickname: state.nickname,
            profileImage: state.profileImage == null
                ? null
                : File(state.profileImage!.path),
          )
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
