class MessageEntity {
  final String chatId;
  final String message;
  final String sender;

  MessageEntity(
      {required this.sender, required this.chatId, required this.message});

  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
        sender: json['sender'],
        chatId: json['chatId'],
        message: json['message']);
  }
}
