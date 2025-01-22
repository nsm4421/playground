part of '../../../export.pages.dart';

class EditProfileImageFragment extends StatelessWidget {
  const EditProfileImageFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        final radius = MediaQuery.of(context).size.width / 5;
        return Stack(
          children: [
            GestureDetector(
              onTap: context.read<EditProfileCubit>().selectImage,
              child: state.profileImage == null
                  ? CustomCircleAvatarWidget(
                      context.read<EditProfileCubit>().currentUser.profileImage,
                      radius: radius,
                    )
                  : CircleAvatar(
                      radius: radius,
                      backgroundImage: FileImage(
                        File(state.profileImage!.path),
                      ),
                      child: state.profileImage == null
                          ? Icon(
                              Icons.add_a_photo_outlined,
                              size: radius,
                            )
                          : null,
                    ),
            ),
            if (state.profileImage != null)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: context.read<EditProfileCubit>().unSelectImage,
                ),
              )
          ],
        );
      },
    );
  }
}
