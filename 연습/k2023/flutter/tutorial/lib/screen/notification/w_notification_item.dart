import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/notification/vo/vo_notification.dart';
import 'package:flutter/material.dart';
import "package:timeago/timeago.dart" as timeago;

class NotificationItemWidget extends StatefulWidget {
  final TossNotification notification;
  final VoidCallback onTap;

  const NotificationItemWidget(
      {super.key, required this.notification, required this.onTap});

  @override
  State<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  static const double leftPadding = 10;
  static const double iconWidth = 25;
  static const double titleFontSize = 12;
  static const double descriptionFontSize = 16;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: leftPadding),
        color: widget.notification.isRead
            ? context.backgroundColor
            : context.appColors.unReadColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Width(leftPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  widget.notification.type.iconPath,
                  width: iconWidth,
                ),
                widget.notification.type.name.text.gray300
                    .size(titleFontSize)
                    .make(),
                const Expanded(child: SizedBox()),
                timeago
                    .format(widget.notification.time,
                        locale: context.locale.languageCode)
                    .text
                    .make(),
                const Width(10)
              ],
            ),
            widget.notification.description.text.white
                .size(descriptionFontSize)
                .make()
                .pOnly(left: leftPadding + iconWidth)
          ],
        ),
      ),
    );
  }
}
