part of '../export.usecase.dart';

@lazySingleton
class AuthUseCase {
  final AuthRepository _authRepository;
  final GroupChatRepository _groupChatRepository;
  final PrivateChatRepository _privateChatRepository;

  AuthUseCase(
      {required AuthRepository authRepository,
      required GroupChatRepository groupChatRepository,
      required PrivateChatRepository privateChatRepository})
      : _authRepository = authRepository,
        _groupChatRepository = groupChatRepository,
        _privateChatRepository = privateChatRepository;

  Stream<UserEntity?> get authStream => _authRepository.authStream;

  GetUserUseCase get getUser => GetUserUseCase(_authRepository);

  SignUpUseCase get signUp => SignUpUseCase(_authRepository);

  SignInUseCase get signIn => SignInUseCase(_authRepository);

  SignOutUseCase get signOut => SignOutUseCase(_authRepository);

  EditProfileUseCase get editProfile => EditProfileUseCase(_authRepository);

  InitSocketUseCase get initSocket => InitSocketUseCase(
      authRepository: _authRepository,
      groupChatRepository: _groupChatRepository,
      privateChatRepository: _privateChatRepository);
}
