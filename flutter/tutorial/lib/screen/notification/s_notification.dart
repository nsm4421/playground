import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/notification/vo/mock_notification.dart';
import 'package:fast_app_base/screen/notification/w_notification_dialog.dart';
import 'package:fast_app_base/screen/notification/w_notification_item.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryDarkGrey,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title:Text("Notification")
          ),
          SliverList(delegate: SliverChildBuilderDelegate(
            childCount: notifications.length,
            (context, index) => NotificationItemWidget(notification: notifications[index], onTap: () {
              NotificationDialog(notifications: [
                notifications[0],
                notifications[1],
              ],).show();
            },),
          ))
        ],
      ),
    );
  }
}
