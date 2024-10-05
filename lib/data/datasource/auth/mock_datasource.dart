part of 'datasource.dart';

class MockAuthDataSource implements AuthDataSource {
  late AuthUserModel? _mockUser;
  late StreamController<AuthUserModel?> _mockAuthStreamController;
  final _authUser = const AuthUserModel(
      id: 'mock_user_id',
      username: 'mock_username',
      avatar_url: 'https://picsum.photos/200/300');

  MockAuthDataSource() {
    _mockUser = _authUser;
    _mockAuthStreamController = StreamController<AuthUserModel?>();
  }

  @override
  Stream<AuthUserModel?> get authStateStream {
    Future.delayed(const Duration(seconds: 2), () {
      _mockAuthStreamController.add(_mockUser);
      _mockAuthStreamController.close();
    });
    return _mockAuthStreamController.stream;
  }

  @override
  AuthUserModel? get authUser => _mockUser;

  @override
  String? get currentUid => _mockUser?.id;

  @override
  bool get isAuthorized => true;

  @override
  Future<AuthUserModel?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    _mockUser = _authUser;
    return _mockUser;
  }

  @override
  Future<void> signOut() async {
    _mockUser = null;
  }

  @override
  Future<AuthUserModel?> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String avatarUrl}) async {
    _mockUser = _authUser;
    return _mockUser;
  }
}
