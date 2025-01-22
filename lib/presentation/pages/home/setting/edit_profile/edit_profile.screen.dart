part of '../../../export.pages.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nicknameController;
  String? _helperText;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController()..addListener(_handleNickname);
    _nicknameController.text = context.read<EditProfileCubit>().state.nickname;
  }

  @override
  void dispose() {
    super.dispose();
    _nicknameController
      ..removeListener(_handleNickname)
      ..dispose();
  }

  void _handleNickname() {
    final text = _nicknameController.text.trim();
    context.read<EditProfileCubit>().update(nickname: text);
    setState(() {
      _helperText = Regex.nickname.validate(text);
    });
  }

  void _handleSubmit() async {
    FocusScope.of(context).unfocus();
    await context.read<EditProfileCubit>().submit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const EditProfileImageFragment(),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.account_box_outlined),
                  helperText: _helperText),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: _handleSubmit,
        child: const Icon(Icons.chevron_right),
      ),
    );
  }
}
