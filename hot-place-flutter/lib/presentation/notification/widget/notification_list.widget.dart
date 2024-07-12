import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/date.util.dart';
import '../../../data/entity/notification/notification.entity.dart';
import '../bloc/notification.bloc.dart';

class NotificationListWidget extends StatefulWidget {
  final List<NotificationEntity> notifications;

  const NotificationListWidget(this.notifications, {super.key});

  @override
  State<NotificationListWidget> createState() => _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<NotificationListWidget> {
  _handleDelete(String notificationId) => () {
        if ((context.read<NotificationBloc>().state
            is NotificationLoadingState)) return;
        context
            .read<NotificationBloc>()
            .add(DeleteNotificationEvent(notificationId));
      };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.notifications.length,
        itemBuilder: (_, index) {
          final item = widget.notifications[index];
          return ListTile(
            title: Text("${item.message}"),
            subtitle: (item.createdAt != null)
                ? Text(DateUtil.formatTimeAgo(item.createdAt!))
                : null,
            trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: _handleDelete(item.id!)),
          );
        });
  }
}
