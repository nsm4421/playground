import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/presentation/pages/feed/display/feed/display_feed.page.dart';
import 'package:portfolio/presentation/pages/travel/travel.page.dart';

import '../../../../core/dependency_injection/configure_dependencies.dart';
import '../../../bloc/bottom_nav/bottom_nav.cubit.dart';
import '../../chat/private_chat/display/display_private_chat.page.dart';
import '../../setting/setting.page.dart';

part "entry.fragment.dart";

part "bottom_nav.widget.dart";

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<BottomNavCubit>(),
        child: BlocBuilder<BottomNavCubit, BottomNav>(
          builder: (context, state) {
            return Scaffold(
                body: EntryFragment(state),
                bottomNavigationBar: BottomNavWidget(state));
          },
        ));
  }
}
