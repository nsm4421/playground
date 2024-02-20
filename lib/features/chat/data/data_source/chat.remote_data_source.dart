import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/features/app/constant/firebase.constant.dart';
import 'package:hot_place/features/app/util/uuid.util.dart';
import 'package:hot_place/features/chat/data/model/chat/chat.model.dart';
import 'package:logger/logger.dart';

import '../model/message/message.model.dart';

class RemoteChatDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;

  final _logger = Logger();

  RemoteChatDataSource(
      {required FirebaseAuth auth, required FirebaseFirestore fireStore})
      : _auth = auth,
        _fireStore = fireStore;

  /// 채팅 조회 - 성공 시 채팅 id를 반환, 실패 시 null 반환
  Stream<List<ChatModel>>? findChatStream() {
    try {
      final currentUid = _auth.currentUser?.uid;
      if (currentUid == null) {
        _logger.e("채팅방 생성 실패 - 로그인되지 않은 유저");
        return null;
      }
      return _fireStore
          .collection(CollectionName.chat)
          .where("uid", isEqualTo: currentUid)
          .snapshots()
          .asyncMap((event) => event.docs
              .map((e) => ChatModel.fromJson(e.data() ?? {}))
              .toList());
    } catch (err) {
      return null;
    }
  }

  /// 채팅 생성 - 성공 시 채팅 id를 반환, 실패 시 null 반환
  Future<String?> createChat(ChatModel chat) async {
    try {
      final chatId = UuidUtil.uuid();
      await _fireStore
          .collection(CollectionName.chat)
          .doc(chatId)
          .set(chat.toJson());
      _logger.d("채팅방 $chatId 만들기 성공");
      return chatId;
    } catch (err) {
      _logger.e("채팅방 만들기 실패");
      return null;
    }
  }

  /// 메세지 생성 - 성공 시 메세지 id를 반환, 실패 시 null 반환
  Future<String?> createMessage(MessageModel message) async {
    try {
      final messageId = UuidUtil.uuid();
      await _fireStore
          .collection(CollectionName.chat)
          .doc(message.chatId)
          .collection(CollectionName.message)
          .doc(messageId)
          .set(message.toJson());
      _logger.d("메세지 $messageId 만들기 성공");
      return messageId;
    } catch (err) {
      _logger.e("메세지 만들기 실패");
      return null;
    }
  }

  /// 채팅 삭제 - 성공 시 채팅 id를 반환, 실패 시 null 반환
  Future<String?> deleteChat(String chatId) async {
    try {
      // TODO : 권한 검사
      await _fireStore.collection(CollectionName.chat).doc(chatId).delete();
      _logger.d("채팅방 $chatId 삭제 성공");
      return chatId;
    } catch (err) {
      _logger.e("채팅방 삭제 실패");
      return null;
    }
  }

  /// 메세지 삭제 - 성공 시 메세지 id를 반환, 실패 시 null 반환
  Future<String?> deleteMessage(MessageModel message) async {
    try {
      // TODO : 권한 검사
      await _fireStore
          .collection(CollectionName.chat)
          .doc(message.chatId)
          .collection(CollectionName.message)
          .doc(message.id)
          .delete();
      _logger.d("메세지 삭제 성공");
      return message.id;
    } catch (err) {
      _logger.e("채팅방 삭제 실패");
      return null;
    }
  }
}
