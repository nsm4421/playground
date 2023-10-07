import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/utils/date_format_util.dart';
import 'package:flutter/material.dart';

class MessageCardWidget extends StatelessWidget {
  const MessageCardWidget({
    Key? key,
    required this.message,
    required this.isMyMessage,
  }) : super(key: key);
  final MessageModel message;
  final bool isMyMessage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: isMyMessage
              ? Colors.teal.withOpacity(0.5)
              : Colors.grey.withOpacity(0.5),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            5,
                          ),
                        ),
                      ),
                      child: Text(
                        message.message ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              if (message.createdAt != null)
                Positioned(
                  bottom: 2,
                  right: 10,
                  child: Text(
                    DateFormatUtils.formatTimeAgo(message.createdAt!),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
