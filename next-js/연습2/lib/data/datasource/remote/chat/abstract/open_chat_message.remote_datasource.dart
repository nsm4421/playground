part of "../impl/open_chat_message.remote_datasource_impl.dart";

abstract class OpenChatMessageRemoteDataSource
    implements ChatMessageRemoteDataSource<OpenChatMessageModel> {
  Future<Iterable<OpenChatMessageWithUserModel>> fetchMessages(
      {required String chatId,
      required DateTime beforeAt,
      required int from,
      required int to,
      bool ascending = true});

  RealtimeChannel getMessageChannel(
      {required String key,
      void Function(OpenChatMessageModel newModel)? onInsert,
      void Function(
              OpenChatMessageModel oldModel, OpenChatMessageModel newModel)?
          onUpdate,
      void Function(OpenChatMessageModel oldModel)? onDelete});
}
