import 'package:chat_app/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      storage: FirebaseStorage.instance),
);

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  ChatRepository({
    required this.firestore,
    required this.auth,
    required this.storage,
  });

  Future<bool> sendTextMessage({
    required String chatRoomId,
    required String text,
  }) async {
    try {
      final sender = auth.currentUser;
      final messageId = (const Uuid()).v1();
      if (sender?.uid == null) throw Exception('[ERROR]AUNTHOIZED');
      await firestore
          .collection('chats')
          .doc(chatRoomId)
          .collection('messages')
          .doc(messageId)
          .set(MessageModel(
            messageId: messageId,
            chatRoomId: chatRoomId,
            message: text,
            createdAt: DateTime.now(),
            senderUid: sender?.uid,
          ).toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<MessageModel>> getMessages({
    required String chatRoomId,
    int? skipCount,
    int? takeCount,
  }) async =>
      (await firestore
              .collection('chats')
              .doc(chatRoomId)
              .collection('messages')
              .orderBy('createdAt')
              .get()
              .then((snapshot) => takeCount == null
                  ? snapshot.docs.skip(skipCount ?? 0)
                  : snapshot.docs.skip(skipCount ?? 0).take(takeCount)))
          .map((e) => MessageModel.fromJson(e.data()))
          .toList();

  Stream<List<MessageModel>> getMessageStream(String chatRoomId) => firestore
          .collection('chats')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('createdAt')
          .snapshots()
          .asyncMap((e) async {
        List<MessageModel> messages = [];
        for (var doc in e.docs) {
          messages.add(MessageModel.fromJson(doc.data()));
        }
        return messages;
      });
}
