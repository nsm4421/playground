import 'package:hot_place/features/user/data/data_source/user.remote_data_source.dart';
import 'package:hot_place/features/user/domain/entity/contact/contact.entity.dart';
import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';
import 'package:hot_place/features/user/domain/repository/user.repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final RemoteUserDataSource userDataSource;

  UserRepositoryImpl(this.userDataSource);

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async =>
      await userDataSource.verifyPhoneNumber(phoneNumber);

  @override
  Future<void> verifyOtpNumber(String otpCode) async =>
      await userDataSource.verifyOtpNumber(otpCode);

  @override
  bool get isAuthorized => userDataSource.isAuthorized;

  @override
  String? get currentUid => userDataSource.currentUid;

  @override
  Future<void> signOut() async => await userDataSource.signOut();

  @override
  Future<void> insertUser(UserEntity user) async =>
      await userDataSource.insertUser(user);

  @override
  Future<void> updateUser(UserEntity user) async =>
      await userDataSource.updateUser(user);

  @override
  Stream<List<UserEntity>> get allUserStream => userDataSource.allUserStream;

  @override
  Stream<UserEntity> getUserStream(String uid) =>
      userDataSource.getUserStream(uid);

  @override
  Future<List<ContactEntity>> getDeviceNumber() async =>
      await userDataSource.getDeviceNumber();
}
