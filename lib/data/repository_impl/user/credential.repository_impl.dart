import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/repository/user/credential.repository.dart';
import '../../data_source/user/credential.data_source.dart';

@Singleton(as: CredentialRepository)
class CredentialRepositoryImpl extends CredentialRepository {
  final CredentialDataSource credentialDataSource;
  final UserDataSource userDataSource;

  CredentialRepositoryImpl(
      {required this.credentialDataSource, required this.userDataSource});

  @override
  bool get isAuthenticated => currentUid != null;

  @override
  String? get currentUid => credentialDataSource.currentUid;

  @override
  Stream<User?> get currentUserStream => credentialDataSource.currentUserStream;

  @override
  Future<void> signOut() async => await credentialDataSource.signOut();

  @override
  Future<UserCredential> googleSignIn() async =>
      await credentialDataSource.googleSignIn();
}
