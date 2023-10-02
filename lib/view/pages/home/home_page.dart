import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/common.dart';
import '../../../domain/usecase/display/display_usecase.dart';
import '../../../service_locator.dart';
import '../../main/cubit/top_app_bar_cubit.dart';
import 'menu_bloc/menu_bloc.dart';
import 'menu_bloc/menu_event.dart';
import 'menu_bloc/menu_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<MallTypeCubit, MallType>(
        builder: (BuildContext _, MallType state) => BlocProvider(
          create: (_) =>
              MenuBloc(locator<DisplayUseCase>())..add(MenuInitialized(state)),
          child: HomePageView(),
        ),
      );
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<MallTypeCubit, MallType>(
        listener: (BuildContext context, MallType state) =>
            context.read<MenuBloc>().add(MenuInitialized(state)),
        listenWhen: (MallType previous, MallType next) =>
            (previous.index != next.index),
        child: BlocBuilder<MenuBloc, MenuState>(
          builder: (BuildContext _, MenuState state) {
            switch (state.status) {
              case Status.initial:
              case Status.loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case Status.success:
                return Center(
                  child: Text(state.menus.toString()),
                );
              case Status.error:
                return Center(
                  child: Text("Error"),
                );
            }
          },
        ),
      );
}
