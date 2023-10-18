import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/components/user_image.widget.dart';
import 'package:my_app/presentation/features/home/bloc/swipe/swipe.event.dart';

import '../../../core/constant/status.enum.dart';
import '../../../model/user/user.model.dart';
import 'bloc/swipe/swipe.bloc.dart';
import 'bloc/swipe/swipe.state.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.initial:
            case Status.loading:
              return const Center(child: CircularProgressIndicator());

            case Status.success:
              return Column(
                children: [
                  InkWell(
                    onDoubleTap: () {},
                    child: Draggable<UserModel>(
                      data: state.users[0],
                      feedback: UserProfileImageWidget(state.users[0]),
                      childWhenDragging: (state.users.length > 1)
                          ? UserProfileImageWidget(state.users[1])
                          : Container(),
                      onDragEnd: (drag) {
                        if (drag.velocity.pixelsPerSecond.dx < 0) {
                          context
                              .read<SwipeBloc>()
                              .add(SwipeLeftEvent(state.users[0]));
                        } else {
                          context
                              .read<SwipeBloc>()
                              .add(SwipeRightEvent(state.users[0]));
                        }
                      },
                      child: UserProfileImageWidget(state.users[0]),
                    ),
                  ),
                ],
              );
            case Status.error:
              return Center(
                child: Text('There aren\'t any more users.',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
              );
          }
        },
      ),
    );
  }
}
