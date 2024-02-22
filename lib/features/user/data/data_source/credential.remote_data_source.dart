import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/features/user/data/model/user/base_user.model.dart';
import 'package:http/http.dart';

import '../../../app/constant/user.constant.dart';

class RemoteCredentialDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;

  RemoteCredentialDataSource(
      {required FirebaseAuth auth, required FirebaseFirestore fireStore})
      : _fireStore = fireStore,
        _auth = auth;

  Future<String> createToken({
    required BaseUserModel user,
    required Provider provider,
  }) async {
    const String endPoint = "https://createtoken-q4wmgs3riq-uc.a.run.app";
    Map<String, dynamic> payload = user.toJson();
    payload['provider'] = provider;
    return await post(Uri.parse(endPoint), body: payload)
        .then((res) => res.body);
  }

  Future<UserCredential> signInWithCustomToken(String token) async =>
      await _auth.signInWithCustomToken(token);
}
