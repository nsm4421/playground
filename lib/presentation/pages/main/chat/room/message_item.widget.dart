part of 'chat_room.page.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget(this._message, {super.key});

  final ChatMessageEntity _message;

  _handleDeleteMessage() async {}

  @override
  Widget build(BuildContext context) {
    return Text(_message.content ?? 'test');
  }
}
