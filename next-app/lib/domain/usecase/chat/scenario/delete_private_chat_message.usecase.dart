part of "../chat.usecase_module.dart";

/// DM 메세지 가져오기
class DeletePrivateChatMessageEvent {
  final PrivateChatMessageRepository _repository;

  DeletePrivateChatMessageEvent(this._repository);

  Future<ResponseWrapper<void>> call(String messageId) async {
    return await _repository.deleteMessageById(messageId);
  }
}
