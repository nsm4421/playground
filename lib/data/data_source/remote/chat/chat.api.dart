import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/data/dto/chat/chat_message/chat_message.dto.dart';
import 'package:my_app/data/mapper/chat_message_mapper.dart';
import 'package:uuid/uuid.dart';

import '../../../../domain/model/chat/chat_message/chat_message.model.dart';
import '../../../dto/chat/chat_room/chat_room.dto.dart';

class ChatApi {
  ChatApi({required FirebaseAuth auth, required FirebaseFirestore db})
      : _auth = auth,
        _db = db;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  static const String _chatCollectionName = "chat";
  static const String _messageCollectionName = "message";
  static const String _orderByFieldName = "createdAt";

  /// create chat room then return chat room id
  Future<void> createChatRoom({
    required String chatRoomName,
    required List<String> hashtags,
  }) async {
    // TODO : 실제 로그인한 유저 uid 사용하기
    // final uid = _auth.currentUser?.uid;
    const uid = 'test user id';
    if (uid == null) throw Exception('NOT_LOGIN');
    final chatRoomId = (const Uuid()).v1();
    await _db.collection(_chatCollectionName).doc(chatRoomId).set(ChatRoomDto(
            chatRoomId: chatRoomId,
            chatRoomName: chatRoomName,
            hashtags: hashtags,
            uidList: [uid],
            hostUid: uid,
            createdAt: DateTime.now())
        .toJson());
  }

  Future<List<ChatRoomDto>> getChatRooms() async {
    final res = (await _db
            .collection(_chatCollectionName)
            .orderBy(_orderByFieldName)
            .get())
        .docs
        .map((e) => ChatRoomDto.fromJson(e.data()))
        .toList();
    return res;
  }

  Future<ChatRoomDto> getChatRoomById(String chatRoomId) async =>
      ChatRoomDto.fromJson((await _db
              .collection(_chatCollectionName)
              .orderBy(_orderByFieldName)
              .where("chatRoomId", isEqualTo: chatRoomId)
              .get())
          .docs[0]
          .data());

  Future<List<ChatMessageDto>> getChatMessages(chatRoomId) async => (await _db
          .collection(_chatCollectionName)
          .doc(chatRoomId)
          .collection(_messageCollectionName)
          .orderBy(_orderByFieldName, descending: true)
          .get())
      .docs
      .map((e) => ChatMessageDto.fromJson(e.data()))
      .toList();

  Stream<List<ChatMessageModel>> getChatMessageStream(String chatRoomId) => _db
          .collection(_chatCollectionName)
          .doc(chatRoomId)
          .collection(_messageCollectionName)
          .orderBy(_orderByFieldName)
          .snapshots()
          .asyncMap((e) async {
        List<ChatMessageModel> messages = [];
        for (var doc in e.docs) {
          messages.add(ChatMessageDto.fromJson(doc.data()).toModel());
        }
        return messages;
      });
}
