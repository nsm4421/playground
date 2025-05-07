part of "../impl/private_chat_message.remote_datasource_impl.dart";

abstract class PrivateChatMessageRemoteDataSource
    implements ChatMessageRemoteDataSource<PrivateChatMessageModel> {
  String getChatId(String receiver, {String? sender});

  Future<Iterable<PrivateChatMessageWithUserModelForRpc>> fetchLastMessages(
      DateTime afterAt);

  Future<Iterable<PrivateChatMessageWithUserModel>> fetchMessages(
      {required DateTime beforeAt,
      required String chatId,
      int take = 20,
      bool ascending = true});

  RealtimeChannel getMessageChannel(
      {required String key,
      void Function(PrivateChatMessageModel newModel)? onInsert,
      void Function(PrivateChatMessageModel oldModel,
              PrivateChatMessageModel newModel)?
          onUpdate,
      void Function(PrivateChatMessageModel oldModel)? onDelete});
}
