import 'package:chat/chat.dart';

class LocalMessage {
  String _id;

  String get id => _id;
  String chatId;
  Message message;
  ReceiptStatus status;

  LocalMessage(this.chatId, this.message, this.status);

  Map<String, dynamic> toMap() => {
        'chat_id': chatId,
        'id': message.id,
        'status': status.value(),
        ...message.toJson()
      };

  factory LocalMessage.fromMap(Map<String, dynamic> json) {
    final message = Message(
        from: json['from'],
        to: json['to'],
        timestamp: json['timestamp'],
        contents: json['contents']);
    final localMessage =
        LocalMessage(json['chat_id'], message, EnumParsing.fromString(json['status']));
    localMessage._id = json['id'];
    return localMessage;
  }
}
