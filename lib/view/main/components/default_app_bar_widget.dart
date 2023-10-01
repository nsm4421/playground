import '../cubit/top_app_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/theme/custom/custom_theme.dart';

class DefaultAppBarWidget extends StatelessWidget {
  const DefaultAppBarWidget({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TopAppBarCubit, TopAppBarState>(
        builder: (BuildContext _, TopAppBarState state) => Container(
          child: AppBar(
            title: Text(
              label,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: state.isMarketMall
                        ? Theme.of(context).colorScheme.background
                        : Theme.of(context).colorScheme.contentPrimary,
                  ),
            ),
            elevation: 0,
            backgroundColor: state.isMarketMall
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.background,
            centerTitle: true,
          ),
        ),
      );
}
