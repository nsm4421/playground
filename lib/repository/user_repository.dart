import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sns/model/vo_user.dart';

class UserRepository {
  static Future<UserVo?> findByUid(String uid) async {
    var fetched = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    if (fetched.size == 0) return null;
    return UserVo.fromJson(fetched.docs.first.data());
  }

  static Future<bool> signUp(UserVo user) async {
    try {
      await FirebaseFirestore.instance.collection('users').add(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
