part of '../../export.pages.dart';

class DisplayProfileWidget extends StatelessWidget {
  const DisplayProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (state.user?.profileImage != null)
                CustomCircleAvatarWidget(state.user!.profileImage),
              (16.width),
              Text(
                state.user?.nickname ?? '',
                style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    context.push(Routes.editProfile.path);
                  },
                  icon: const Icon(Icons.edit_outlined))
            ],
          ),
        );
      },
    );
  }
}
