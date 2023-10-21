import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/features/home/home_error.widget.dart';

import '../../../core/constant/status.enum.dart';
import 'bloc/swipe/swipe.bloc.dart';
import 'bloc/swipe/swipe.state.dart';
import 'home_success.widget.dart';

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
              return HomeSuccessWidget(state);
            case Status.error:
              return const HomeErrorWidget();
          }
        },
      ),
    );
  }
}
