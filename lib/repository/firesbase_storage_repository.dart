import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStoreageRepositoryProvider =
    Provider((ref) => FirebaseStorageRepository(FirebaseStorage.instance));

class FirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  FirebaseStorageRepository(this.firebaseStorage);

  /// @params ref 파일 저장 경로
  /// @params file 저장할 파일
  /// @output 다운로드 경로 (실패 시 null)
  Future<String?> saveFile({required String ref, var file}) async {
    UploadTask? uploadTask;
    if (file == null) return null;
    if (file is File) {
      uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    } else if (file is Uint8List) {
      uploadTask = firebaseStorage.ref().child(ref).putData(file);
    }
    if (uploadTask == null) return null;
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}
