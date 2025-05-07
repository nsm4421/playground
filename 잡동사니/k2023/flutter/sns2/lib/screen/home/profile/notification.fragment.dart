import 'package:flutter/material.dart';
import 'package:my_app/core/util/time_diff.util.dart';
import 'package:my_app/repository/notification/notification.repository.dart';

import '../../../configurations.dart';
import '../../../core/response/response.dart';
import '../../../domain/model/notification/notification.model.dart';

class NotificationFragment extends StatefulWidget {
  const NotificationFragment({super.key});

  @override
  State<NotificationFragment> createState() => _NotificationFragmentState();
}

class _NotificationFragmentState extends State<NotificationFragment> {
  List<NotificationModel> _notifications = [];

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getNotification();
    });
  }

  _getNotification() async {
    final response = await getIt<NotificationRepository>().getNotifications();
    if (response.status == Status.success) {
      setState(() {
        _notifications.addAll(response.data ?? []);
      });
    }
  }

  _handleDeleteById(String nid) => () async {
        final response =
            await getIt<NotificationRepository>().deleteNotificationById(nid);
        if (response.status == Status.success) {
          setState(() {
            _notifications.removeWhere((element) => element.nid == nid);
          });
        }
      };

  _handleDeleteAll() async {
    final response =
        await getIt<NotificationRepository>().deleteAllNotification();
    if (response.status == Status.success) {
      setState(() {
        _notifications = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) => ListTile(
                          onTap: _handleDeleteById(_notifications[index].nid!),
                          title: Text(_notifications[index].title ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                          subtitle: Text(_notifications[index].message ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                              softWrap: true),
                          trailing: _notifications[index].createdAt != null
                              ? Text(
                                  TimeDiffUtil.getTimeDiffRep(
                                      _notifications[index].createdAt!),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary),
                                )
                              : const SizedBox(),
                        )))),
        floatingActionButton: FloatingActionButton.small(
            onPressed: _handleDeleteAll,
            child: const Icon(Icons.delete_forever)),
      );
}
