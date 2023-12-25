import 'package:flutter/material.dart';
import 'package:my_app/core/constant/chat.enum.dart';
import 'package:my_app/domain/model/chat/message.model.dart';
import 'package:my_app/repository/chat/chat.repository.dart';

import '../../../configurations.dart';
import '../../../core/response/response.dart';
import '../../../core/util/time_diff.util.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen(this.chatId, {super.key});

  final String chatId;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(chatId),
        ),
        body: FutureBuilder<Stream<List<MessageModel>>>(
            future: getIt<ChatRepository>().getMessageStreamByChatId(chatId),
            builder: (_, streamSnapshot) {
              switch (streamSnapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                case ConnectionState.done:
                  return streamSnapshot.hasData && !streamSnapshot.hasError
                      ? StreamBuilder<List<MessageModel>>(
                          stream: streamSnapshot.data,
                          builder: (_, messageSnapshot) => messageSnapshot
                                      .hasData &&
                                  !messageSnapshot.hasError
                              // getting messages success
                              ? _ChatScreenView(
                                  chatId: chatId,
                                  messages: messageSnapshot.data ?? [])
                              // getting messages fail
                              : Center(
                                  child: Text("error on getting message data",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium)))
                      // getting stream fail
                      : Center(
                          child: Text("can't get stream",
                              style:
                                  Theme.of(context).textTheme.displayMedium));
              }
            }),
      );
}

class _ChatScreenView extends StatefulWidget {
  const _ChatScreenView({required this.chatId, required this.messages});

  final String chatId;
  final List<MessageModel> messages;

  @override
  State<_ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<_ChatScreenView> {
  late TextEditingController _tec;
  late ScrollController _sc;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
    _sc = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
    _sc.dispose();
  }

  _handleSendMessage() async {
    try {
      await getIt<ChatRepository>()
          .sendMessage(
              chatId: widget.chatId,
              type: MessageType.text,
              content: _tec.text.trim())
          .then((res) {
        if (res.status == Status.success) {
          _tec.clear();
          _animateToBottom();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('sending chat fail...'),
            duration: Duration(seconds: 2),
          ));
        }
      });
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  _animateToBottom() {
    if (_sc.hasClients) {
      _sc.animateTo(
        _sc.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _sc,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, index) =>
                      _ChatBubble(widget.messages[index]),
                  itemCount: widget.messages.length),
            ),
          ),
          const Divider(indent: 20, endIndent: 20),
          TextFormField(
            controller: _tec,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                decorationThickness: 0,
                color: Theme.of(context).colorScheme.primary),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(Icons.send,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: _handleSendMessage),
              hintText: 'hi',
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(20.0),
            ),
          )
        ],
      );
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble(this._message);

  final MessageModel _message;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment:
            _message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _message.isMine
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.secondaryContainer),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // content
                    Text(
                      _message.content ?? '',
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: _message.isMine
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary),
                    ),
                    // created at
                    if (_message.createdAt != null)
                      Column(
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            TimeDiffUtil.getTimeDiffRep(_message.createdAt!),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                          ),
                        ],
                      ),
                  ],
                )),
          )
        ],
      );
}
