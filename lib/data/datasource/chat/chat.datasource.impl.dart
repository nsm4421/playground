import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:my_app/core/constant/error_code.dart';
import 'package:my_app/domain/model/chat/chat.model.dart';
import 'package:my_app/domain/model/chat/chat_message.model.dart';
import '../../../core/constant/firebase.dart';
import '../../../core/exception/custom_exeption.dart';
import 'chat.datasource.dart';

class LocalChatDataSourceImpl implements LocalChatDataSource {}

class RemoteChatDataSourceImpl implements RemoteChatDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;
  final Logger _logger;

  static const bucketName = "chats";
  static const orderByForChat = "lastTalkAt";
  static const orderByForMessage = "createdAt";

  RemoteChatDataSourceImpl(
      {required FirebaseAuth auth,
      required FirebaseFirestore db,
      required FirebaseStorage storage,
      required Logger logger})
      : _auth = auth,
        _db = db,
        _storage = storage,
        _logger = logger;

  // TODO : 나중에 자기 자신의 채팅과 메세지만 조회할 수 있도록 코드 수정하기
  @override
  Stream<Iterable<ChatModel>> getChatStream() {
    try {
      return _db
          .collection(CollectionName.user.name)
          .doc(_auth.currentUser?.uid)
          .collection(CollectionName.chat.name)
          .orderBy(orderByForChat)
          .snapshots()
          .asyncMap((event) =>
              event.docs.map((doc) => ChatModel.fromJson(doc.data())));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Stream<Iterable<ChatMessageModel>> getMessageStream(String chatId) {
    try {
      return _db
          .collection(CollectionName.user.name)
          .doc(_auth.currentUser?.uid)
          .collection(CollectionName.chat.name)
          .doc(chatId)
          .collection(CollectionName.message.name)
          .orderBy(orderByForMessage)
          .snapshots()
          .asyncMap((event) =>
              event.docs.map((doc) => ChatMessageModel.fromJson(doc.data())));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveChat(ChatModel model) async {
    try {
      final chat = _auditChat(model);
      await _db
          .collection(CollectionName.user.name)
          .doc(model.uid)
          .collection(CollectionName.chat.name)
          .doc(chat.id)
          .set(chat.toJson());
      await _db
          .collection(CollectionName.user.name)
          .doc(chat.opponentUid)
          .collection(CollectionName.chat.name)
          .doc(chat.id)
          .set(chat.swap.toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveChatMessage(ChatMessageModel model) async {
    try {
      // 메세지 저장
      final message = _auditMessage(model);
      await _db
          .collection(CollectionName.user.name)
          .doc(message.senderUid)
          .collection(CollectionName.chat.name)
          .doc(message.chatId)
          .collection(CollectionName.message.name)
          .doc(message.id)
          .set(message.toJson());
      await _db
          .collection(CollectionName.user.name)
          .doc(message.receiverUid)
          .collection(CollectionName.chat.name)
          .doc(message.chatId)
          .collection(CollectionName.message.name)
          .doc(message.id)
          .set(message.toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> updateLastMessage(ChatMessageModel model) async {
    try {
      final message = _auditMessage(model);
      await _db
          .collection(CollectionName.user.name)
          .doc(message.senderUid)
          .collection(CollectionName.chat.name)
          .doc(message.chatId)
          .update({'lastMessage': message.toJson()});
      await _db
          .collection(CollectionName.user.name)
          .doc(message.receiverUid)
          .collection(CollectionName.chat.name)
          .doc(message.chatId)
          .update({'lastMessage': message.toJson()});
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> deleteChat(ChatModel model) async {
    try {
      final chat = _auditChat(model);
      await _db
          .collection(CollectionName.user.name)
          .doc(chat.uid)
          .collection(CollectionName.chat.name)
          .doc(chat.id)
          .delete();
      await _db
          .collection(CollectionName.user.name)
          .doc(chat.opponentUid)
          .collection(CollectionName.chat.name)
          .doc(chat.id)
          .delete();
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> deleteChatMessage(ChatMessageModel model) async {
    try {
      final message = _auditMessage(model);
      await _db
          .collection(CollectionName.user.name)
          .doc(message.senderUid)
          .collection(CollectionName.chat.name)
          .doc(message.chatId)
          .collection(CollectionName.message.name)
          .doc(message.id)
          .delete();
      await _db
          .collection(CollectionName.user.name)
          .doc(message.receiverUid)
          .collection(CollectionName.chat.name)
          .doc(message.chatId)
          .collection(CollectionName.message.name)
          .doc(message.id)
          .delete();
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  ChatModel _auditChat(ChatModel model) {
    if (model.id.isEmpty) {
      throw CustomException(errorCode: ErrorCode.invalidArgs);
    }
    return model.copyWith(
        createdAt: model.createdAt ?? DateTime.now().toIso8601String());
  }

  ChatMessageModel _auditMessage(ChatMessageModel model) {
    if (model.id.isEmpty) {
      throw CustomException(errorCode: ErrorCode.invalidArgs);
    }
    return model.copyWith(
        createdAt: model.createdAt ?? DateTime.now().toIso8601String(),
        senderUid: _auth.currentUser?.uid);
  }
}
