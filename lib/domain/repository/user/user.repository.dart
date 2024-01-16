import 'package:image_picker/image_picker.dart';

import '../../../core/response/response_wrapper.dart';
import '../../model/auth/user.model.dart';
import '../base.repository.dart';

abstract class UserRepository extends Repository {

  Stream<UserModel> currentUserStream();

  Stream<UserModel> userStreamById(String userId);

  Future<ResponseWrapper<UserModel>> getCurrentUser();

  Future<ResponseWrapper<UserModel>> findUserById(String userId);

  Future<ResponseWrapper<UserModel>> editProfile(
      {String? nickname, XFile? profileImageData});
}
