import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/common.dart';
import '../../../common/widget/dialog_widget.dart';
import '../../../domain/usecase/display/display_usecase.dart';
import '../../../service_locator.dart';
import '../../main/cubit/top_app_bar_cubit.dart';
import 'bloc/menu/menu_bloc.dart';
import 'bloc/menu/menu_event.dart';
import 'bloc/menu/menu_state.dart';
import 'component/global_naviagation_bar_view.dart';
import 'component/global_navigation_bar.dart';

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

  bool _listenWhen(MallType previous, MallType next) =>
      (previous.index != next.index);

  bool _consumerListenWhen(MenuState previous, MenuState next) =>
      (previous.status != next.status);

  _listener(BuildContext _, MallType state) =>
      locator<MenuBloc>()..add(MenuInitialized(state));

  _consumerListener(BuildContext context, MenuState state) async {
    if (state.status != Status.error) return;
    final bool result =
        await DialogWidget.errorDialog(context, state.error) ?? false;
    if (result) {
      locator<MenuBloc>().add(MenuInitialized(MallType.market));
    }
  }

  @override
  Widget build(BuildContext context) => BlocListener<MallTypeCubit, MallType>(
        listener: _listener,
        listenWhen: _listenWhen,
        child: BlocConsumer<MenuBloc, MenuState>(
          builder: (BuildContext _, MenuState state) {
            switch (state.status) {
              case Status.initial:
              case Status.loading:
                return Center(child: CircularProgressIndicator());
              case Status.success:
                return DefaultTabController(
                  key: ValueKey<MallType>(state.mallType),
                  length: state.menus.length,
                  child: Column(
                    children: [
                      GlobalNavBar(
                        menus: state.menus,
                      ),
                      GlobalNavbarView(
                        menus: state.menus,
                        mallType: state.mallType,
                      ),
                    ],
                  ),
                );
              case Status.error:
                return Center(child: Text("Error"));
            }
          },
          listener: _consumerListener,
          listenWhen: _consumerListenWhen,
        ),
      );
}
