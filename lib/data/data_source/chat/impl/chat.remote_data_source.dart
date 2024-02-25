import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/core/constant/firebase.constant.dart';
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
      .orderBy('createdAt', descending: true)
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
  Future<String> createChat(ChatModel chat) async {
    final currentUid = _getCurrentUidOrElseThrow();
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(currentUid)
        .collection(CollectionName.chat.name)
        .doc(chat.id)
        .set(chat.copyWith(createdAt: DateTime.now()).toJson());
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(chat.guestUid)
        .collection(CollectionName.chat.name)
        .doc(chat.id)
        .set(chat.copyWith(createdAt: DateTime.now()).toJson());
    return chat.id;
  }

  @override
  Future<String> createMessage(MessageModel message) async {
    final currentUid = _getCurrentUidOrElseThrow();
    if (message.senderUid != currentUid) {
      throw Exception('sender uid is not matched');
    }
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(message.senderUid)
        .collection(CollectionName.chat.name)
        .doc(message.chatId)
        .collection(CollectionName.message.name)
        .doc(message.id)
        .set(
            message.copyWith(isSeen: true, createdAt: DateTime.now()).toJson());
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(message.receiverUid)
        .collection(CollectionName.chat.name)
        .doc(message.chatId)
        .collection(CollectionName.message.name)
        .doc(message.id)
        .set(message.copyWith(createdAt: DateTime.now()).toJson());
    return message.id;
  }

  @override
  Future<void> seenMessageUpdate(MessageModel message) async {
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(message.senderUid)
        .collection(CollectionName.chat.name)
        .doc(message.chatId)
        .collection(CollectionName.message.name)
        .doc(message.id)
        .update(message.copyWith(isSeen: true).toJson());
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(message.receiverUid)
        .collection(CollectionName.chat.name)
        .doc(message.chatId)
        .collection(CollectionName.message.name)
        .doc(message.id)
        .update(message.copyWith(isSeen: true).toJson());
  }

  @override
  Future<String> deleteChat(ChatModel chat) async {
    final currentUid = _getCurrentUidOrElseThrow();
    if (chat.guestUid != currentUid || chat.hostUid != currentUid) {
      throw Exception('current user not belongs to chat');
    }
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(chat.hostUid)
        .collection(CollectionName.chat.name)
        .doc(chat.id)
        .delete();
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(chat.guestUid)
        .collection(CollectionName.chat.name)
        .doc(chat.id)
        .delete();
    return chat.id;
  }

  @override
  Future<String> deleteMessage(MessageModel message) async {
    final currentUid = _getCurrentUidOrElseThrow();
    if (message.senderUid != currentUid) {
      throw Exception('sender uid not match current uid');
    }
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
