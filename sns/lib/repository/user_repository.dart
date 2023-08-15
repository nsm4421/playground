import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sns/model/user_dto.dart';
import 'package:image_picker/image_picker.dart';

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

  static UploadTask? uploadThumbnail(
      {required XFile xFile, required String filename}) {
    try {
      var f = File(xFile.path);
      var ref = FirebaseStorage.instance.ref().child('users').child(filename);
      final metaData = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'thumbnail-file-path': xFile.path});
      return ref.putFile(f, metaData);
    } catch (e) {
      return null;
    }
  }
}
