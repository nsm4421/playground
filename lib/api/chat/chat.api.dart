import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_app/core/constant/collection_name.enum.dart';
import 'package:my_app/domain/dto/chat/chat.dto.dart';
import 'package:my_app/domain/dto/chat/message.dto.dart';
import 'package:my_app/domain/model/chat/message.model.dart';
import 'package:uuid/uuid.dart';
import '../../core/constant/chat.enum.dart';
import '../../domain/model/user/user.model.dart';

class ChatApi {
  ChatApi(
      {required FirebaseAuth auth,
      required FirebaseFirestore db,
      required FirebaseStorage storage})
      : _auth = auth,
        _db = db,
        _storage = storage;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  /// create chat room and return its id
  Future<String> createChat({
    required String chatId,
    required List<String> uidList,
  }) async =>
      await _db
          .collection(CollectionName.chat.name)
          .doc(chatId)
          .set(ChatDto(
                  chatId: chatId,
                  uidList: {...uidList, _getCurrentUidOrElseThrow()},
                  createdAt: DateTime.now())
              .toJson())
          .then((_) => chatId);

  /// find chat id which is direct message by opponent uid
  /// or else create chat and return its id
  Future<String> getDirectMessageChatId(String opponentUid) async {
    final currentUid = _getCurrentUidOrElseThrow();
    final chats = (await _db
            .collection(CollectionName.chat.name)
            .where(Filter.and(
                Filter('type', isEqualTo: ChatType.dm.name),
                Filter.or(
                  Filter('uidList', arrayContains: currentUid),
                  Filter('uidList', arrayContains: opponentUid),
                )))
            .get()
            .then((snapshot) => snapshot.docs))
        .map((doc) => doc.data())
        .map((data) => ChatDto.fromJson(data))
        .toList();
    return chats.isEmpty
        ? await createChat(
            chatId: const Uuid().v1(), uidList: [currentUid, opponentUid])
        : chats[0].chatId;
  }

  /// get stream of chat message
  Future<Stream<List<MessageModel>>> getMessageStreamByChatId(
      String chatId) async {
    final currentUid = _getCurrentUidOrElseThrow();
    final users = await Future.wait(ChatDto.fromJson(
            (await _db.collection(CollectionName.chat.name).doc(chatId).get())
                    .data() ??
                {})
        .uidList
        .where((uid) => uid.isNotEmpty)
        .map((uid) async => await _findUserByUid(uid)));

    return _db
        .collection(CollectionName.chat.name)
        .doc(chatId)
        .collection(CollectionName.message.name)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .asyncMap((e) async => await Future.wait(e.docs
                .map((doc) => MessageDto.fromJson(doc.data()))
                .map((dto) async {
              final sender =
                  users.firstWhere((element) => element.uid == dto.senderUid);
              return dto
                  .toModel()
                  .copyWith(isMine: currentUid == sender.uid, sender: sender);
            })));
  }

  /// save chat message
  Future<void> sendMessage(MessageDto message) async => await _db
      .collection(CollectionName.chat.name)
      .doc(message.chatId)
      .collection(CollectionName.message.name)
      .doc(message.messageId)
      .set(message
          .copyWith(
              senderUid: _getCurrentUidOrElseThrow(),
              createdAt: message.createdAt ?? DateTime.now())
          .toJson())
      .then((_) => message.messageId);

  Future<List<String>> saveChatImages(
          {required String chatId,
          required List<Uint8List> imageDataList}) async =>
      await Future.wait(imageDataList.map((imageData) async => await _storage
          .ref(CollectionName.chat.name)
          .child('$chatId.jpg')
          .putData(imageData)
          .then((task) => task.ref.getDownloadURL())));

  String _getCurrentUidOrElseThrow() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw const CertificateException('NOT_LOGIN');
    return uid;
  }

  Future<UserModel> _findUserByUid(String uid) async => UserModel.fromJson(
      (await _db.collection(CollectionName.user.name).doc(uid).get()).data() ??
          {});
}
