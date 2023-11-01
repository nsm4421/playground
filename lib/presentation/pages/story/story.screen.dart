import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/pages/story/bloc/story.bloc.dart';
import 'package:my_app/presentation/pages/story/bloc/story.event.dart';
import 'package:my_app/presentation/pages/story/component/story.fragment.dart';

import '../../../core/constant/enums/status.enum.dart';
import '../../../dependency_injection.dart';
import 'bloc/story.state.dart';
class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocProvider(
          create: (_) => getIt<StoryBloc>()..add(StoryInitializedEvent()),
          child: BlocBuilder<StoryBloc, StoryState>(
            builder: (_, state) {
              switch (state.status) {
                case Status.initial:
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());
                case Status.success:
                  return StoryFragment(state.stories);
                case Status.error:
                  return const Text("FAIL");
              }
            },
          ),
        ),
      );
}
