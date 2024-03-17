import 'package:flutter/material.dart';

import '../../../domain/entity/chat/message.entity.dart';

class MessageItem extends StatelessWidget {
  const MessageItem(this._message, {super.key});

  final MessageEntity _message;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment:
            _message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: _message.isSender
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.tertiaryContainer),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_message.content ?? "",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: _message.isSender
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary)),
                Text(
                  _message.createdAt?.toLocal().toString() ?? "",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ],
      );
}
