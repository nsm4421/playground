part of '../../../export.pages.dart';

class CreateFeedPage extends StatelessWidget {
  const CreateFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateFeedCubit>(),
      child: const CreateFeedScreen(),
    );
  }
}
