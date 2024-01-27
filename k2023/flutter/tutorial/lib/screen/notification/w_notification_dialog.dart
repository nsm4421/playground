import 'package:fast_app_base/screen/notification/vo/vo_notification.dart';
import 'package:fast_app_base/screen/notification/w_notification_item.dart';
import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:nav/enum/enum_nav_ani.dart';

class NotificationDialog extends DialogWidget {
  final List<TossNotification> notifications;

  NotificationDialog({super.key, required this.notifications, super.animation = NavAni.Bottom});

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends DialogState<NotificationDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type:MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...widget.notifications.map((e) => NotificationItemWidget(
              notification: e,
              onTap: () {
                widget.hide();
              })).toList()
        ],
      ),
    );
  }
}
