import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/dependency_injection/configure_dependencies.dart';
import '../../bloc/bottom_nav/bottom_nav.cubit.dart';

part "entry.fragment.dart";

part "bottom_nav.widget.dart";

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:  (_) => getIt<BottomNavCubit>(),
        child: BlocBuilder<BottomNavCubit, BottomNav>(
          builder: (context, state){
            return Scaffold(
              body: EntryFragment(state),
              bottomNavigationBar: BottomNavWidget(state)
            );
          },
        ) );
  }
}
