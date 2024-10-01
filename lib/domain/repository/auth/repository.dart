import 'package:injectable/injectable.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/data/datasource/auth/datasource.dart';

import '../../../core/response/response_wrapper.dart';
import '../../entity/auth/presence.dart';

part 'repository_impl.dart';

abstract interface class AuthRepository {

  Stream<PresenceEntity?> get authStateStream;

  PresenceEntity? get currentUser;

  bool get isAuthorized;

  Future<ResponseWrapper<PresenceEntity?>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username});

  Future<ResponseWrapper<PresenceEntity?>> signInWithEmailAndPassword(
      String email, String password);

  Future<ResponseWrapper<void>> signOut();
}
