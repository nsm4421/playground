import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../core/constant/collection_name.enum.dart';
import '../../domain/dto/notification/notification.dto.dart';

class NotificationApi {
  NotificationApi(
      {required FirebaseAuth auth,
      required FirebaseFirestore db,
      required FirebaseStorage storage})
      : _auth = auth,
        _db = db,
        _storage = storage;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  Future<NotificationDto> getNotificationByNid(String nid) async => await _db
      .collection(CollectionName.notification.name)
      .doc(nid)
      .get()
      .then((e) => e.data())
      .then((data) => NotificationDto.fromJson(data ?? {}));

  /// notifications
  Future<List<NotificationDto>> getNotifications() async => (await _db
          .collection(CollectionName.notification.name)
          .where('receiverUid', isEqualTo: _getCurrentUidOrElseThrow())
          .where('isSeen', isEqualTo: false)
          .get())
      .docs
      .map((e) => e.data() ?? {})
      .map((data) => NotificationDto.fromJson(data))
      .where((dto) => dto.nid.isNotEmpty && dto.receiverUid.isNotEmpty)
      .toList();

  /// create notification and return its id
  Future<String> createNotification(NotificationDto notification) async {
    final nid =
        notification.nid.isNotEmpty ? notification.nid : const Uuid().v1();
    await _db.collection(CollectionName.notification.name).doc(nid).set(
        notification
            .copyWith(
                nid: nid, createdAt: notification.createdAt ?? DateTime.now())
            .toJson());
    return nid;
  }

  /// update notification isSeen field as true
  Future<void> deleteNotificationById(String nid) async => await _db
      .collection(CollectionName.notification.name)
      .doc(nid)
      .update({'isSeen': true});

  String _getCurrentUidOrElseThrow() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw const CertificateException('NOT_LOGIN');
    return uid;
  }
}
