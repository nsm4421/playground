import 'package:flutter/material.dart';
import 'package:my_app/screen/component/user_item.widget.dart';

import '../../api/user/user.api.dart';
import '../../configurations.dart';
import '../../core/constant/user.enum.dart';
import '../../domain/model/user/user.model.dart';

class FollowListWidget extends StatefulWidget {
  const FollowListWidget(this.type, {super.key});

  final FollowType type;

  @override
  State<FollowListWidget> createState() => _FollowListWidgetState();
}

class _FollowListWidgetState extends State<FollowListWidget> {
  late Stream<List<UserModel>> _stream;
  late String _currentUid;

  @override
  void initState() {
    super.initState();
    _currentUid = getIt<UserApi>().currentUid!;
    _stream = widget.type == FollowType.following
        ? getIt<UserApi>().getFollowingStream()
        : getIt<UserApi>().getFollowerStream();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<UserModel>>(
      stream: _stream,
      builder: (_, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError || !snapshot.hasData) {
              return const Center(child: Text("ERROR"));
            }
            return snapshot.data!.isEmpty
                ? const Center(child: Text("Not User Founded"))
                : ListView.separated(
                    itemBuilder: (_, index) {
                      final user = snapshot.data![index];
                      return UserItemWidget(
                        user: user,
                        currentUid: _currentUid,
                        addUnFollowButton: true,
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(),
                    itemCount: snapshot.data!.length);
        }
      });
}
