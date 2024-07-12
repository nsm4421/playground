import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/data/entity/notification/notification.entity.dart';
import 'package:hot_place/presentation/notification/bloc/notification.bloc.dart';
import 'package:hot_place/presentation/notification/widget/notification_list.widget.dart';
import 'package:hot_place/presentation/setting/bloc/user.bloc.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _View();
  }
}

class _View extends StatefulWidget {
  const _View({super.key});

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  _handleDeleteAll() {
    if (context.read<NotificationBloc>().state is NotificationLoadingState) {
      return;
    }
    context.read<NotificationBloc>().add(
        DeleteAllNotificationsEvent(context.read<UserBloc>().state.user.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.notifications),
        title: const Text("알림"),
        actions: [
          IconButton(
              onPressed: _handleDeleteAll,
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: StreamBuilder<List<NotificationEntity>>(
          stream: context.read<NotificationBloc>().notificationStream,
          builder: (context, snapshot) {
            if (!snapshot.hasError &&
                snapshot.connectionState == ConnectionState.active) {
              return NotificationListWidget(snapshot.data ?? []);
            } else if (snapshot.hasError) {
              return const Center(child: Text("ERROR"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
