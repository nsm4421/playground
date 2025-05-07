part of "../abstract/auth.remote_datasource.dart";

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  AuthRemoteDataSourceImpl({required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  String get tableName => TableName.account.name;

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  Stream<AuthState> get authStream => _client.auth.onAuthStateChange;

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      _logger.d('sign up request email:$email');
      return await _client.auth
          .signUp(email: email, password: password)
          .then((res) => res.user);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      _logger.d('sign in request email:$email');
      return await _client.auth
          .signInWithPassword(email: email, password: password)
          .then((res) => res.user);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<void> insertAccount(AccountModel account) async {
    try {
      return await _client.rest.from(tableName).insert(account.toJson());
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<User?> updateMetaData({String? nickname, String? profileImage}) async {
    try {
      return await _client.auth
          .updateUser(UserAttributes(data: {
            if (nickname != null) "nickname": nickname,
            if (profileImage != null) "profile_image": profileImage,
          }))
          .then((res) => res.user);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<void> updateAccount(
      {required String uid, String? nickname, String? profileImage}) async {
    try {
      return await _client.rest.from(tableName).update({
        if (nickname != null) "nickname": nickname,
        if (profileImage != null) "profile_image": profileImage,
      }).eq("id", uid);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<String> upsertProfileImage(
      {required String uid, required File profileImage}) async {
    try {
      final bytes = await profileImage.readAsBytes();
      final fileName = 'public/profile_image_$uid';
      await _client.storage.from(BucketName.profileImage.name).uploadBinary(
            fileName,
            bytes,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: true,
            ),
          );
      return _client.storage
          .from(BucketName.profileImage.name)
          .getPublicUrl(fileName);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<AccountModel> findByUid(String uid) async {
    try {
      return await _client.rest
          .from(tableName)
          .select("*")
          .eq("id", uid)
          .then((res) => res.first)
          .then(AccountModel.fromJson);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<int> countByField(
      {required String field, required String value}) async {
    try {
      return await _client.rest.from(tableName).count().eq(field, value);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  AccountModel audit(AccountModel model) => throw UnimplementedError();
}
