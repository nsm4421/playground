part of '../../export.pages.dart';

class ProfileImageFragment extends StatelessWidget {
  const ProfileImageFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Stack(
          children: [
            GestureDetector(
              onTap: context.read<SignUpCubit>().selectImage,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width / 5,
                backgroundImage: state.profileImage == null
                    ? null
                    : FileImage(
                        File(state.profileImage!.path),
                      ),
                child: state.profileImage == null
                    ? Icon(
                        Icons.add_a_photo_outlined,
                        size: MediaQuery.of(context).size.width / 10,
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
                  onPressed: context.read<SignUpCubit>().unSelectImage,
                ),
              )
          ],
        );
      },
    );
  }
}
