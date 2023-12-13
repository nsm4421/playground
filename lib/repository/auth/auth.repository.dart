import 'package:my_app/repository/base/repository.dart';

import '../../core/response/response.dart';

abstract class AuthRepository extends Repository {
  Future<Response<void>> signInWithEmailAndPassword(String email, String password);
}
