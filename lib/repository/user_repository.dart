import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sns/model/user_dto.dart';

class UserRepository {
  static Future<UserDto?> findByUid(String uid) async {
    var fetched = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    if (fetched.size == 0) return null;
    return UserDto.fromJson(fetched.docs.first.data());
  }

  static Future<bool> signUp(UserDto user) async {
    try {
      await FirebaseFirestore.instance.collection('users').add(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
