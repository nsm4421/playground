import 'package:chat_app/model/chat_room_model.dart';
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
    storage: FirebaseStorage.instance,
  ),
);

class ChatRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ChatRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required FirebaseStorage storage,
  })  : _auth = auth,
        _firestore = firestore,
        _storage = storage;

  /// 채팅방 생성하기
  /// @param roomName 채팅방 방제
  /// @param hashtags 해쉬태그를 #로 연결한 문자열
  /// @return 개설한 채팅방의 id
  Future<String?> createChatRoom(
      {required String chatRoomName, required List<String> hashtags}) async {
    try {
      // 권한 체크
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw Exception("NOT LOGIN");
      final chatRoomId = const Uuid().v1();
      await _firestore.collection('chats').doc(chatRoomId).set(
            ChatRoomModel(
              host: uid,
              uidList: [uid],
              chatRoomId: chatRoomId,
              chatRoomName: chatRoomName,
              hashtags: hashtags,
              createdAt: DateTime.now(),
            ).toJson(),
          );
      return chatRoomId;
    } catch (e) {
      return null;
    }
  }

  /// 채팅방 목록 가져오기
  /// @param skipCount skip 개수
  /// @param takeCount 가져올 방 개수
  /// @return 채팅방 목록
  Future<List<ChatRoomModel>> getChatRoomList({
    int? skipCount,
    int? takeCount,
  }) async {
    try {
      return (await _firestore.collection('chats').get().then((snapshot) =>
              snapshot.docs.skip(skipCount ?? 0).take(takeCount ?? 100)))
          .map((doc) => ChatRoomModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 채팅방 수정하기
  /// @param chatRoomId 채팅방 id
  /// @param chatRoomName 채팅방 방제
  /// @param hashtags 해쉬태그를 #로 연결한 문자열
  /// @return 개설한 채팅방의 id
  Future<bool> editChatRoom(
      {required String chatRoomId,
      required String chatRoomName,
      required List<String> hashtags}) async {
    try {
      final uid = _auth.currentUser?.uid;
      final chatRoom = await getChatRoomById(chatRoomId);
      if ((uid != chatRoom?.host) || (uid == null)) throw Exception("ERROR");
      if (chatRoom == null) throw Exception("NOT FETCHED");
      await _firestore.collection('chats').doc(chatRoomId).set(
            chatRoom
                .copyWith(chatRoomName: chatRoomName, hashtags: hashtags)
                .toJson(),
          );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 채팅방 삭제하기
  /// @param chatRoomId 채팅방 id
  /// @return 삭제 여부
  Future<bool> deleteChatRoom({
    required String chatRoomId,
  }) async {
    try {
      final uid = _auth.currentUser?.uid;
      final hostUid =
          await getChatRoomById(chatRoomId).then((chatRoom) => chatRoom?.host);
      if (uid != hostUid) throw Exception("UnAuthorized");
      await _firestore.collection('chats').doc(chatRoomId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 텍스트 메세지 보내기
  /// @param chatRoomId 채팅방 id
  /// @param text 텍스트 메세지
  /// @return 성공 여부
  Future<bool> sendTextMessage({
    required String chatRoomId,
    required String text,
  }) async {
    try {
      final sender = _auth.currentUser;
      final messageId = (const Uuid()).v1();
      if (sender?.uid == null) throw Exception('[ERROR]AUNTHOIZED');
      await _firestore
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

  /// 채팅방 가져오기
  /// @param chatRoomId
  /// @return chatRoom(future)
  Future<ChatRoomModel?> getChatRoomById(String chatRoomId) async =>
      await _firestore
          .collection('chats') // Replace with your Firestore collection name
          .where('chatRoomId', isEqualTo: chatRoomId)
          .get()
          .then((snapshot) => snapshot.docs.first.data())
          .then((data) => ChatRoomModel.fromJson(data));

  /// 메세지 가져오기
  /// @param chatRoomId 채팅방 id
  /// @param skipCount 건너 뛸 메세지 개수
  /// @param takeCount 가져올 메세지 개수
  /// @return 메세지 List Future
  Future<List<MessageModel>> getMessages({
    required String chatRoomId,
    int? skipCount,
    int? takeCount,
  }) async =>
      (await _firestore
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

  Stream<List<ChatRoomModel>> getChatRoomStream() => _firestore
          .collection('chats')
          .orderBy('createdAt')
          .snapshots()
          .asyncMap((e) async {
        List<ChatRoomModel> chatRooms = [];
        for (var doc in e.docs) {
          chatRooms.add(ChatRoomModel.fromJson(doc.data()));
        }
        return chatRooms;
      });

  Stream<List<MessageModel>> getMessageStream(String chatRoomId) => _firestore
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
