import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/data/model/user/user.model.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/repository/user/credential.repository.dart';
import '../../data_source/user/credential.data_source.dart';

@Singleton(as: CredentialRepository)
class CredentialRepositoryImpl extends CredentialRepository {
  final CredentialDataSource _credentialDataSource;
  final UserDataSource _userDataSource;

  CredentialRepositoryImpl(
      {required CredentialDataSource credentialDataSource,
      required UserDataSource userDataSource})
      : _credentialDataSource = credentialDataSource,
        _userDataSource = userDataSource;

  @override
  bool get isAuthenticated => currentUid != null;

  @override
  String? get currentUid => _credentialDataSource.currentUid;

  @override
  Stream<User?> get currentUserStream =>
      _credentialDataSource.currentUserStream;

  @override
  Future<void> signOut() async => await _credentialDataSource.signOut();

  @override
  Future<UserEntity> googleSignIn() async {
    final credential = await _credentialDataSource.googleSignIn();
    final uid = credential.user?.uid;
    UserModel model = await _userDataSource.findUserById(uid!);
    if (model.uid.isEmpty) {
      model = UserEntity.fromGoogleAccount(credential).toModel();
      await _userDataSource.insertUser(model);
    }
    return UserEntity.fromModel(model);
  }
}
