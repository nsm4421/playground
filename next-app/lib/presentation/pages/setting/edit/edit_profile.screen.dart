part of "edit_profile.page.dart";

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen(this._account, {super.key});

  final AccountEntity _account;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  XFile? _xFile;
  bool _readOnly = true;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nicknameTec;
  late ImagePicker _picker;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nicknameTec = TextEditingController(text: widget._account.nickname!);
    _picker = ImagePicker();
  }

  @override
  void dispose() {
    super.dispose();
    _nicknameTec.dispose();
  }

  _handlePickProfileImage() async {
    await _picker.pickImage(source: ImageSource.gallery).then((res) {
      if (res != null) {
        setState(() {
          _xFile = res;
        });
      }
    });
  }

  _handleSubmit() async {
    _formKey.currentState?.save();
    final nickname = _nicknameTec.text.trim();
    final ok = _formKey.currentState!.validate();
    if (!ok) return;
    await context.read<AuthBloc>().isNicknameDuplicated(nickname).then((res) {
      context.read<AuthBloc>().add(EditProfileEvent(
          nickname: widget._account.nickname != nickname ? nickname : null,
          profileImage: _xFile != null ? File(_xFile!.path) : null));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          IconButton(onPressed: _handleSubmit, icon: const Icon(Icons.upload))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필 이미지
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("PROFILE IMAGE",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: _handlePickProfileImage,
                      child: Center(
                        child: CircleAvatar(
                            backgroundImage: _xFile != null
                                ? FileImage(File(_xFile!.path))
                                : CachedNetworkImageProvider(
                                    widget._account.profileImage!),
                            radius: MediaQuery.of(context).size.width / 6),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("NICKNAME",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                        readOnly: _readOnly,
                        controller: _nicknameTec,
                        decoration: InputDecoration(
                            border:
                                _readOnly ? null : const OutlineInputBorder(),
                            helperText: _readOnly
                                ? "To Modify Nickname, Tap"
                                : "Press Nickname",
                            helperStyle: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                            suffixIcon: IconButton(
                                icon: Icon(_readOnly ? Icons.edit : Icons.check,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                onPressed: () {
                                  setState(() {
                                    _readOnly = false;
                                  });
                                }))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
