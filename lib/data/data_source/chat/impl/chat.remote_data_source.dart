import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/core/constant/firebase.constant.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/data_source/chat/chat.data_source.dart';
import 'package:hot_place/data/model/chat/chat.model.dart';
import 'package:hot_place/data/model/chat/message.model.dart';

class RemoteChatDataSource extends ChatDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;

  RemoteChatDataSource(
      {required FirebaseAuth auth, required FirebaseFirestore fireStore})
      : _auth = auth,
        _fireStore = fireStore;

  @override
  Stream<List<ChatModel>> getChatStream() => _fireStore
      .collection(CollectionName.user.name)
      .doc(_getCurrentUidOrElseThrow())
      .collection(CollectionName.chat.name)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => doc.data())
          .map((json) => ChatModel.fromJson(json))
          .toList());

  @override
  Stream<List<MessageModel>> getMessageStream(String chatId) => _fireStore
      .collection(CollectionName.user.name)
      .doc(_getCurrentUidOrElseThrow())
      .collection(CollectionName.chat.name)
      .doc(chatId)
      .collection(CollectionName.message.name)
      .orderBy('createdAt', descending: false)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => doc.data())
          .map((json) => MessageModel.fromJson(json))
          .toList());

  @override
  Future<ChatModel> findChatById(String chatId) async => await _fireStore
      .collection(CollectionName.user.name)
      .doc(_getCurrentUidOrElseThrow())
      .collection(CollectionName.chat.name)
      .doc(chatId)
      .get()
      .then((snapshot) => snapshot.data())
      .then((json) => ChatModel.fromJson(json ?? {}));

  @override
  Future<MessageModel> findMessageById(
          {required String chatId, required String messageId}) async =>
      await _fireStore
          .collection(CollectionName.user.name)
          .doc(_getCurrentUidOrElseThrow())
          .collection(CollectionName.chat.name)
          .doc(chatId)
          .collection(CollectionName.message.name)
          .doc(messageId)
          .get()
          .then((snapshot) => snapshot.data())
          .then((data) => MessageModel.fromJson(data ?? {}));

  @override
  Future<String> createChat(ChatModel chat) async {
    final currentUid = _getCurrentUidOrElseThrow();
    final opponentUid = chat.opponentUid;

    // 현재 유저 컬렉션에 채팅 정보 저장
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(currentUid)
        .collection(CollectionName.chat.name)
        .doc(chat.id)
        .set(chat
            .copyWith(createdAt: chat.createdAt ?? DateTime.now())
            .toJson());
    // 상대방 컬렉션에 채팅 정보 저장
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(opponentUid)
        .collection(CollectionName.chat.name)
        .doc(chat.id)
        .set(chat
            .copyWith(
                opponentUid: currentUid,
                createdAt: chat.createdAt ?? DateTime.now())
            .toJson());
    return chat.id;
  }

  @override
  Future<String> createMessage(MessageModel message) async {
    final senderUid = _getCurrentUidOrElseThrow(); // sender는 현재 로그인한 유저
    final receiverUid = message.receiverUid;
    final messageId = message.id.isNotEmpty ? message.id : UuidUtil.uuid();
    // sender user 컬렉션에 메세지 정보 저장
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(senderUid)
        .collection(CollectionName.chat.name)
        .doc(message.chatId)
        .collection(CollectionName.message.name)
        .doc(messageId)
        .set(message
            .copyWith(
                id: messageId,
                senderUid: senderUid,
                receiverUid: receiverUid,
                seenAt: DateTime.now(),
                createdAt: message.createdAt ?? DateTime.now())
            .toJson());
    // receiver user 컬렉션에 메세지 정보 저장
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(receiverUid)
        .collection(CollectionName.chat.name)
        .doc(message.chatId)
        .collection(CollectionName.message.name)
        .doc(messageId)
        .set(message
            .copyWith(
                id: messageId,
                senderUid: senderUid,
                receiverUid: receiverUid,
                createdAt: message.createdAt ?? DateTime.now())
            .toJson());
    return messageId;
  }

  // TODO
  @override
  Future<void> seenMessageUpdate(
      {required String chatId, required String messageId}) async {
    throw UnimplementedError();
    // await _fireStore
    //     .collection(CollectionName.user.name)
    //     .doc(_getCurrentUidOrElseThrow())
    //     .collection(CollectionName.chat.name)
    //     .doc(chatId)
    //     .collection(CollectionName.message.name)
    //     .doc(messageId)
    //     .update({});
  }

  @override
  Future<String> deleteChatById(String chatId) async {
    final currentUid = _getCurrentUidOrElseThrow();
    final chat = await findChatById(chatId);
    // 현재 유저 컬렉션에 채팅 정보 삭제
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(currentUid)
        .collection(CollectionName.chat.name)
        .doc(chat.id)
        .delete();
    // 상대방 유저 컬렉션에 채팅 정보 삭제
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(chat.opponentUid)
        .collection(CollectionName.chat.name)
        .doc(chat.id)
        .delete();
    return chat.id;
  }

  @override
  Future<String> deleteMessage(MessageModel message) async {
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(message.senderUid)
        .collection(CollectionName.chat.name)
        .doc(message.chatId)
        .collection(CollectionName.message.name)
        .doc(message.id)
        .delete();
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(message.receiverUid)
        .collection(CollectionName.chat.name)
        .doc(message.chatId)
        .collection(CollectionName.message.name)
        .doc(message.id)
        .delete();
    return message.id;
  }

  String _getCurrentUidOrElseThrow() {
    final currentUid = _auth.currentUser?.uid;
    if (currentUid == null) {
      throw Exception('not login');
    }
    return currentUid;
  }
}
