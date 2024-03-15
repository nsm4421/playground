import 'package:hot_place/data/model/response/response.model.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';

abstract class UserRepository {
  // 유저 데이터 생성
  Future<ResponseModel<void>> insertUser(UserEntity user);

  // 유저 데이터 수정
  Future<ResponseModel<void>> updateUser(UserEntity user);

  // 유저 목록 stream
  ResponseModel<Stream<List<UserEntity>>> getAllUserStream();

  // 특정 유저 stream
  ResponseModel<Stream<UserEntity>> getUserStream(String uid);
}
