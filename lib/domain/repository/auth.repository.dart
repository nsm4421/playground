import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/domain/repository/repository.dart';

import '../../core/utils/response_wrappper/response_wrapper.dart';

abstract class AuthRepository extends Repository {
  Future<ResponseWrapper<UserCredential>> signInWithGoogle();
  Future<bool> checkNicknameDuplicated(String nickname);
}
