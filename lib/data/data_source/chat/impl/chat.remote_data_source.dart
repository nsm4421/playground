import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<void> createChat(ChatModel chat) {
    // TODO: implement createChat
    throw UnimplementedError();
  }

  @override
  Future<void> createMessage(MessageModel message) {
    // TODO: implement createMessage
    throw UnimplementedError();
  }

  @override
  Future<void> deleteChat(ChatModel chat) {
    // TODO: implement deleteChat
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMessage(MessageModel message) {
    // TODO: implement deleteMessage
    throw UnimplementedError();
  }

  @override
  Stream<List<ChatModel>> getChatStream() {
    // TODO: implement getChatStream
    throw UnimplementedError();
  }

  @override
  Stream<List<MessageModel>> getMessageStream(String chatId) {
    // TODO: implement getMessageStream
    throw UnimplementedError();
  }

  @override
  Future<void> seenMessageUpdate(MessageModel message) {
    // TODO: implement seenMessageUpdate
    throw UnimplementedError();
  }
}
