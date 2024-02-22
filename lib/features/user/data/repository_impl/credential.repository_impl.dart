import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/features/user/data/model/user/base_user.model.dart';
import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as Kakao;

import '../../../app/constant/user.constant.dart';
import '../../domain/repository/credential.repository.dart';
import '../data_source/credential.remote_data_source.dart';

@Singleton(as: CredentialRepository)
class CredentialRepositoryImpl extends CredentialRepository {
  final RemoteCredentialDataSource credentialDataSource;

  CredentialRepositoryImpl(this.credentialDataSource);

  @override
  Future<UserCredential> kakaoLogin() async {
    final Kakao.User kakaoUser = await Kakao.UserApi.instance.me();
    final user = BaseUserModel(
        uid: kakaoUser.id.toString() ?? '',
        username: kakaoUser.kakaoAccount?.name,
        email: kakaoUser.kakaoAccount?.email,
        profileImageUrl: kakaoUser.kakaoAccount?.profile?.profileImageUrl);
    final String token = await credentialDataSource.createToken(
        user: user, provider: Provider.kakao);
    return await credentialDataSource.signInWithCustomToken(token);
  }
}
