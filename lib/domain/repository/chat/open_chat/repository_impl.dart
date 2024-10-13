part of 'repository.dart';

class OpenChatRepositoryImpl implements OpenChatRepository {
  final OpenChatRoomDataSource _chatRoomDataSource;
  final OpenChatMessageDataSource _messageDataSource;
  final StorageDataSource _storageDataSource;

  OpenChatRepositoryImpl(
      {required OpenChatRoomDataSource chatRoomDataSource,
      required OpenChatMessageDataSource messageDataSource,
      required StorageDataSource storageDataSource})
      : _chatRoomDataSource = chatRoomDataSource,
        _messageDataSource = messageDataSource,
        _storageDataSource = storageDataSource;

  @override
  Future<Either<ErrorResponse, String>> createChat(
      {required String title, required List<String> hashtags}) async {
    try {
      return await _chatRoomDataSource
          .createChatRoom(CreateOpenChatModel(
              title: title,
              hashtags: hashtags,
              last_message_content: 'chat room created'))
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, List<OpenChatEntity>>> fetchChats(
      {required DateTime beforeAt, int take = 20}) async {
    try {
      return await _chatRoomDataSource
          .fetchChatRooms(beforeAt, take: take)
          .then((res) => res.map(OpenChatEntity.from).toList())
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> deleteChat(String chatId) async {
    try {
      return await _chatRoomDataSource.deleteChatRoom(chatId).then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> modifyChat(
      {required String chatId, String? title, List<String>? hashtags}) async {
    try {
      return await _chatRoomDataSource
          .editChatRoom(
              EditOpenChatModel(id: chatId, title: title, hashtags: hashtags))
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, String>> sendMessage(
      {required String chatId, String? content, File? media}) async {
    try {
      assert(content == null && media == null);
      final dto = media == null
          ? CreateOpenChatMessageModel(
              chat_id: chatId, content: content!, media: null)
          : CreateOpenChatMessageModel(
              chat_id: chatId,
              content: content ?? 'media',
              media: await _storageDataSource.uploadImageAndReturnPublicUrl(
                  file: media, bucketName: Buckets.openChat.name));
      // 채팅방 메세지
      return await _messageDataSource.createChatMessage(dto).then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    } finally {
      // 채팅방 정보 업데이트
      await _chatRoomDataSource.editChatRoomMetaData(EditOpenChatMetaDataModel(
          id: chatId,
          last_message_content: content ?? 'media',
          last_message_created_at: customUtil.now));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> deleteChatMessage({
    required String chatId,
    required String messageId,
  }) async {
    try {
      return await _messageDataSource
          .softDeleteChatMessage(messageId)
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    } finally {
      // 채팅방 정보 업데이트
      await _chatRoomDataSource.editChatRoomMetaData(EditOpenChatMetaDataModel(
          id: chatId,
          last_message_content: 'deleted message',
          last_message_created_at: null));
    }
  }

  @override
  Future<Either<ErrorResponse, List<OpenChatMessageEntity>>> fetchMessages(
      {required String chatId,
      required DateTime beforeAt,
      int take = 20}) async {
    try {
      return await _messageDataSource
          .fetchChatMessages(chatId: chatId, beforeAt: beforeAt, take: take)
          .then((res) => res.map(OpenChatMessageEntity.from).toList())
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}
