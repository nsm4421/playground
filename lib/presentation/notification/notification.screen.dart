import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _View();
  }
}

class _View extends StatelessWidget {
  const _View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Expanded(
        // 실제 알림 정보 넣기
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text("TEST $index"),
              );
            }),
      ),
    );
  }
}
