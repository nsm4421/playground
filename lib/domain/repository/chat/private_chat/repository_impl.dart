part of 'repository.dart';

class PrivateChatRepositoryImpl implements PrivateChatRepository {
  final PrivateChatRoomDataSource _chatRoomDataSource;
  final PrivateChatMessageDataSource _messageDataSource;
  final StorageDataSource _storageDataSource;

  PrivateChatRepositoryImpl(
      {required PrivateChatRoomDataSource chatRoomDataSource,
      required PrivateChatMessageDataSource messageDataSource,
      required StorageDataSource storageDataSource})
      : _chatRoomDataSource = chatRoomDataSource,
        _messageDataSource = messageDataSource,
        _storageDataSource = storageDataSource;
}
