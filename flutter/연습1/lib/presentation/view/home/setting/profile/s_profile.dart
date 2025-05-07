part of 'index.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const _usernameMaxLength = 10;
  File? _selectedImage;
  late ImagePicker _imagePicker;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _controller = TextEditingController();
    _controller.text =
        context.read<AuthenticationBloc>().state.currentUser?.username ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _handleSelectImage() async {
    try {
      await _imagePicker.pickImage(source: ImageSource.gallery).then((res) {
        if (res == null) return;
        setState(() {
          _selectedImage = File(res.path);
        });
      });
    } catch (e) {
      getIt<CustomSnackBar>().error(
          title: 'Error',
          description: 'error occurs on selecting profile image');
    }
  }

  _handleUnSelectImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  _handleEditUsername() async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: TextField(
            controller: _controller,
            maxLength: _usernameMaxLength,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
        );
      },
    );
  }

  _handleSubmit() async {
    if (context.read<EditProfileCubit>().state.status != Status.initial) return;
    context.read<EditProfileCubit>().submit(
        username: _controller.text.trim(), profileImage: _selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    final radius = context.width / 4;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),

          /// 프로필 사진
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 2 * radius,
              height: 2 * radius,
              child: GestureDetector(
                onTap: _handleSelectImage,
                child: Stack(
                  children: [
                    _selectedImage == null
                        ? CachedCircularImageWidget(
                            context
                                .read<AuthenticationBloc>()
                                .state
                                .currentUser!
                                .avatarUrl,
                            radius: radius,
                          )
                        : Container(
                            width: radius * 2,
                            height: radius * 2,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(_selectedImage!))),
                          ),
                    if (_selectedImage != null)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: _handleUnSelectImage,
                            icon: Icon(
                              Icons.clear,
                              size: 25,
                              color: context.colorScheme.secondary,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
          const Spacer(flex: 1),

          /// 유저명
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Username", style: context.textTheme.labelLarge),
                (12.0).w,
                Expanded(
                  child: TextField(
                    onTap: _handleEditUsername,
                    controller: _controller,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleSubmit,
        child: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
