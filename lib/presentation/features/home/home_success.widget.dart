import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/user/user.model.dart';
import '../../components/user_bottom_modal.widget.dart';
import '../../components/user_image.widget.dart';
import 'bloc/swipe/swipe.bloc.dart';
import 'bloc/swipe/swipe.event.dart';
import 'bloc/swipe/swipe.state.dart';

class HomeSuccessWidget extends StatelessWidget {
  const HomeSuccessWidget(this.state, {super.key});

  final SwipeState state;

  _handleOnPressed(BuildContext context) => () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        builder: (BuildContext _) => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: UserBottomModal(state.users[0]),
        ),
      );

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            child: Draggable<UserModel>(
              data: state.users[0],
              feedback: UserProfileImageWidget(state.users[0]),
              childWhenDragging: (state.users.length > 1)
                  ? UserProfileImageWidget(state.users[1])
                  : Container(),
              onDragEnd: (drag) {
                if (drag.velocity.pixelsPerSecond.dx < 0) {
                  context.read<SwipeBloc>().add(SwipeLeftEvent(state.users[0]));
                } else {
                  context
                      .read<SwipeBloc>()
                      .add(SwipeRightEvent(state.users[0]));
                }
              },
              child: UserProfileImageWidget(state.users[0]),
            ),
          ),
          const SizedBox(height: 20),
          //  TODO : UI 수정하기
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${state.users[0].nickname}",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                    onPressed: _handleOnPressed(context),
                    child: const Text("더보기")),
              ],
            ),
          ),
        ],
      );
}
